const { Product, validate } = require('../models/product');

exports.allProducts = async (req, res) => {
    const products = await Product.find({});
    if (!products) return res.status(404).json({ message: 'No products' });
    return res.status(200).json(products);
}

exports.productById = async (req, res) => {
    const product = await Product.findById(req.params.id);
    if (!product) return res.status(404).json({ message: 'No products' });
    return res.status(200).json(product);
}

exports.categoricalProducts = async (req, res) => {
    const products = await Product.find({ "category": req.params.id });
    if (!products) return res.status(404).json({ message: 'No products for this category' });
    return res.status(200).json(products);
}

exports.categoricalNonListings = async (req, res) => {
    const products = await Product.find({ "category": req.params.id, "showUser": true });
    if (!products) return res.status(404).json({ message: 'No products for this category' });
    return res.status(200).json(products);
}

exports.allNonListing = async (req, res) => {
    const items = await Product.find({ "askUser": false, "showUser": true });
    if (!items) return res.status(404).json({ message: 'No products List' });
    return res.status(200).json(items);
}

exports.allListing = async (req, res) => {
    const items = await Product.find({ "askUser": true });
    if (!items) return res.status(404).json({ message: 'No products List' });
    return res.status(200).json(items);
}

exports.addProduct = async (req, res) => {
    const { error } = validate(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const { name, description, price, category, image, minimum, rate, } = req.body;

    const product = new Product({
        name,
        category,
        image,
        price,
        description,
        minimum,
        rate,

    });
    await product.save();
    res.status(200).json(product);
}

exports.deleteProduct = async (req, res) => {
    const product = await Product.findByIdAndRemove(req.params.id);
    if (!product) return res.status(404).json({ message: 'Product not found.' });
    return res.status(200).json({ message: 'The product was deleted!' });
}

exports.multipleProductDetails = async (req, res) => {
    const items = req.body
    let prodDetails = []
    for (let i = 0; i < items.length; i++) {
        const product = await Product.findById(items[i].product);
        if (!product) continue;
        prodDetails.push(product)
    }
    // ya herene .json
    return res.status(200).json(prodDetails)
}


exports.updateProduct = async (req, res) => {
    const { price, description, stock, rate, minimum } = req.body;

    if (!(/^\d+$/.test(price))) return res.status(400).json({ message: "Invalid price value" })

    const updatedProduct = await Product.findOneAndUpdate({ "_id": req.params.id }, {
        $set: {
            price: parseFloat(price),
            rate: rate,
            description: description,
            stock: parseFloat(stock),
            minimum: minimum,
        }
    }, { new: true });
    if (!updatedProduct) return res.status(404).json({ message: 'Product not found' });
    res.status(200).json(updatedProduct);
}

exports.updateAskUser = async (req, res) => {
    const { askUser } = req.body;

    const updatedProduct = await Product.findOneAndUpdate({ "_id": req.params.id }, {
        $set: {
            askUser: askUser
        }
    }, { new: true });
    if (!updatedProduct) return res.status(404).json({ message: 'Product not found' });
    res.status(200).json(updatedProduct);
}

exports.updateShowUserStatus = async (req, res) => {
    const { showUser } = req.body;

    const updatedProduct = await Product.findOneAndUpdate({ "_id": req.params.id }, {
        $set: {
            showUser: showUser
        }
    }, { new: true });
    if (!updatedProduct) return res.status(404).json({ message: 'Product not found' });
    res.status(200).json(updatedProduct);
}