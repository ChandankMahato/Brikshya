const mongoose = require('mongoose');
const { Cart } = require('../models/cart');
const { Product } = require('../models/product');

exports.userCart = async (req, res) => {
    const cart = await Cart.findOne({ "user": req.auth.id }).select('items totalPrice checkedOut -_id').populate('items.product');
    if (cart.length == 0) return res.status(404).json({ message: 'No product in cart' });
    return res.status(200).json(cart);
}

exports.userCartTotalPrice = async (req, res) => {
    const cart = await Cart.findOne({ "user": req.auth.id }).select('totalPrice -_id');
    if (cart.length == 0) return res.status(404).json({ message: 'No product in cart' });
    return res.status(200).json(cart);
}

exports.addUpdateUserCart = async (req, res) => {
    const { items, totalPrice } = req.body;
    const user = req.auth.id;
    // same here, req.auth bata line middleware vayesi
    const isUserCartExist = await Cart.findOne({ "user": user });
    if (isUserCartExist == null) {
        // const { error } = validate(req.body);
        // if (error) return res.status(400).json({ message: error.details[0].message });
        const cart = new Cart({
            user,
            items,
            totalPrice,
        });
        await cart.save();
        res.status(200).json({ "message": 'Cart created successfully' });
    } else {
        const updatedCart = await Cart.findOneAndUpdate({ "user": req.auth.id }, {
            $set: {
                items: items,
                totalPrice: totalPrice,
            }
        }, { new: true }).select("items totalPrice checkedOut -_id").populate("items.product")
        if (!updatedCart) return res.status(404).json({ message: 'Cart not found' });
        return res.status(200).json({ message: 'Cart updated succesfully' });
    }
}


exports.resolveCart = async (req, res) => {
    const { items, totalPrice, updatedAt } = req.body;

    if (items.length == 0) return res.status(400).json({ message: "Empty input" });
    const userId = req.auth.id;
    const databaseCart = await Cart.findOne({ user: userId }).select("items totalPrice updatedAt -_id")

    if (databaseCart == null) {
        // const { error } = validate(req.body);
        // if (error) return res.status(400).json({ message: error.details[0].message });
        const cart = new Cart({
            user: userId,
            items,
            totalPrice,
        });
        await cart.save();
        const newCart = await Cart.findOne({ user: req.auth.id }).select("items -_id")
        return res.status(200).json(newCart.items);
    } else {
        const session = await mongoose.startSession()
        session.startTransaction()
        try {
            if (new Date(String(databaseCart.updatedAt)).getTime() >= new Date(String(updatedAt)).getTime()) {
                throw databaseCart
            }
            for (let i = 0; i < items.length; i++) {
                // const { error } = validate(favourites[i]);
                // if (error) throw "At least one data contains error";

                // const fav = Favourite.find({ "user": req.params.id}).select("items -id")

                let canAdd = true


                databaseCart.items.forEach(async (element) => {
                    if (element.product == items[i].product) {
                        canAdd = false
                    }
                });

                if (canAdd) {

                    //calculating current total price
                    const productDetails = await Product.findById(items[i].product);
                    const currentTotalPrice = databaseCart.totalPrice + productDetails.price * items[i].quantity;
                    const product = items[i].product
                    const quantity = items[i].quantity

                    await Cart.findOneAndUpdate({ "user": userId }, {
                        $push: {
                            items: {
                                product: product,
                                quantity: quantity
                            },
                        },
                        $set: {
                            totalPrice: currentTotalPrice
                        }
                    }, { session: session, new: true })
                }
            }
            await session.commitTransaction();
            session.endSession();
        } catch (ex) {
            await session.abortTransaction();
            session.endSession();
        }
        const newCart = await Cart.findOne({ user: req.auth.id }).select("items -_id")
        return res.status(200).json(newCart.items);
    }

}