const { Buy, validate } = require('../models/buy');
const moment = require('moment-timezone');

exports.allPickedBuys = async (req, res) => {
    const buys = await Buy.find({ pickedUp: true }).populate('product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!buys) return res.status(404).json({ message: 'No buys' });
    return res.status(200).json(buys);
}

exports.allPendingBuys = async (req, res) => {
    const buys = await Buy.find({ pickedUp: false }).populate('product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!buys) return res.status(404).json({ message: 'No buys' });
    return res.status(200).json(buys);
}

exports.allPendingBuysForToday = async (req, res) => {
    const currDate = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDate.setHours(0, 0, 0, 0);
    const currDateEnd = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDateEnd.setHours(23, 59, 59, 999);
    const buys = await Buy.find({ pickedUp: false, pickupDate: { $gte: currDate, $lte: currDateEnd } }).populate('product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!buys) return res.status(404).json({ message: 'No buys' });
    return res.status(200).json(buys);
}

exports.allUpcomingPendingBuys = async (req, res) => {
    const currDateEnd = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDateEnd.setHours(23, 59, 59, 999);
    const buys = await Buy.find({ pickedUp: false, pickupDate: { $gt: currDateEnd } }).populate('product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!buys) return res.status(404).json({ message: 'No upcoming buys' });
    return res.status(200).json(buys);
}

exports.userSellHistory = async (req, res) => {
    const buys = await Buy.find({ user: req.auth.id, pickedUp: true }).populate('product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!buys) return res.status(404).json({ message: 'No buys' });
    return res.status(200).json(buys);
}

exports.userPendingSells = async (req, res) => {

    const buys = await Buy.find({ user: req.auth.id, pickedUp: false }).populate('product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!buys) return res.status(404).json({ message: 'No buys' });
    return res.status(200).json(buys);
}

exports.addBuyRequest = async (req, res) => {
    const { product, userLocation, pickupDate, customAddress } = req.body;
    let newDate = new Date(String(pickupDate));
    const { error } = validate({ product, userLocation, customAddress, pickupDate: newDate });
    if (error) {
        res.status(400).json(error.details[0].message);
    }
    const buy = new Buy({
        user: req.auth.id,
        product,
        userLocation,
        pickupDate: newDate,
        customAddress
    });
    await buy.save();
    res.status(200).json(buy);
}

exports.deleteSellRequest = async (req, res) => {
    const buy = await Buy.findByIdAndRemove(req.params.id);
    if (!buy) return res.status(404).json({ message: 'Sell request not found.' });
    return res.status(200).json({ message: 'The sell request was deleted!' });
}

exports.updatePickUpDate = async (req, res) => {
    const { pickupDate } = req.body;

    const updated = await Buy.findOneAndUpdate({ "_id": req.params.id }, {
        $set: {
            pickupDate: new Date(pickupDate),
        }
    }, { new: true });
    if (!updated) return res.status(404).json({ message: 'Buy request not found' });
    res.status(200).json(updated);
}

exports.updatePickedStatus = async (req, res) => {
    const { pickedUp } = req.body;

    const updated = await Buy.findOneAndUpdate({ "_id": req.params.id }, {
        $set: {
            pickedUp: pickedUp,
        }
    }, { new: true });
    if (!updated) return res.status(404).json({ message: 'Buy request not found' });
    res.status(200).json(updated);
}