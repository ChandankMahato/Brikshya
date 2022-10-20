const mongoose = require('mongoose');
const { Favourite, validate } = require('../models/favourite');

exports.userFavourites = async (req, res) => {
    const favourites = await Favourite.findOne({ "user": req.auth.id }).select('items -_id').populate('items.product');
    if (favourites.length == 0) return res.status(404).json({ message: 'No product in favourites' });
    return res.status(200).json(favourites);
}


//this updates favourite if favourite already exist else add user favourite
exports.addUpdateUserFavourites = async (req, res) => {
    const items = req.body;
    const user = req.auth.id;
    // same here, req.auth bata line middleware vayesi
    const isUserFavExist = await Favourite.findOne({ 'user': user });
    if (isUserFavExist == null) {
        // const { error } = validate(items);
        // if (error) return res.status(400).json({ message: error.details[0].message });

        const favourite = new Favourite({
            user,
            items,
        })
        await favourite.save();
        res.status(200).json({ "message": 'Favourtie created successfully' });
    } else {
        const updatedFavs = await Favourite.findOneAndUpdate({ "user": user },
            {
                $set: {
                    items: items,
                }
            }, { new: true }).select("items -_id").populate("items.product")
        if (!updatedFavs) return res.status(404).json({ message: 'Favourites not found' });
        return res.status(200).json({ message: 'Favourite updated succesfully' });
    }
}

// exports.addUserFavourites = async (req, res) => {
// const { error } = validate(req.body);
// if (error) return res.status(400).json({ message: error.details[0].message });

//     // ailay yesari gari rakhne paxi login middleware vayesi
//     // user lai req.auth bata lida hunxa
//     const { user, items } = req.body;

//     const favourite = new Favourite({
//         user,
//         items,
//     });
//     await favourite.save();
//     res.status(200).json(favourite);
// }

exports.resolveFavourites = async (req, res) => {
    const { favourites, updatedAt } = req.body;
    if (favourites.length == 0) return res.status(400).json({ message: "Empty input" })
    const userId = req.auth.id;
    const databaseFavs = await Favourite.findOne({ user: userId }).select("items updatedAt -_id")

    if (databaseFavs == null) {
        // const { error } = validate(favourites);
        // if (error) return res.status(400).json({ message: error.details[0].message });

        const favourite = new Favourite({
            user: userId,
            items: favourites,
        });
        await favourite.save();
        const newFavourite = await Favourite.findOne({ user: userId }).select("items -_id")
        return res.status(200).json(newFavourite.items);
    } else {
        const session = await mongoose.startSession()
        session.startTransaction()
        try {
            if (new Date(String(databaseFavs.updatedAt)).getTime() >= new Date(String(updatedAt)).getTime()) {
                throw databaseFavs
            }
            for (let i = 0; i < favourites.length; i++) {
                // const { error } = validate(favourites[i]);
                // if (error) throw "At least one data contains error";

                // const fav = Favourite.find({ "user": req.params.id}).select("items -id")
                let canAdd = true

                databaseFavs.items.forEach(async (element) => {
                    if (element.product == favourites[i].product) {
                        canAdd = false
                    }
                });

                if (canAdd) {
                    const product = favourites[i].product
                    await Favourite.findOneAndUpdate({ "user": userId }, {
                        $push: {
                            items: {
                                product: product
                            }
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
        const newFavourite = await Favourite.findOne({ user: userId }).select("items -_id")
        return res.status(200).json(newFavourite.items);
    }
}