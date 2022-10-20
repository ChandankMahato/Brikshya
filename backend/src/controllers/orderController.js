const { Order, validate } = require('../models/order');
const { Cart } = require('../models/cart');
const { History } = require('../models/history');
const mongoose = require('mongoose');
const moment = require('moment-timezone');

exports.allOrders = async (req, res) => {
    const orders = await Order.find().populate('items.product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!orders) return res.status(404).json({ message: 'No orders' });
    return res.status(200).json(orders);
}

exports.todayOrders = async (req, res) => {
    const currDate = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDate.setHours(0, 0, 0, 0);
    const currDateEnd = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDateEnd.setHours(23, 59, 59, 999);
    const orders = await Order.find({ deliveryDate: { $gte: currDate, $lte: currDateEnd } }).populate('items.product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!orders) return res.status(404).json({ message: 'No orders for today' });
    return res.status(200).json(orders);
}

exports.pastOrders = async (req, res) => {
    const currDate = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDate.setHours(0, 0, 0, 0);
    const orders = await Order.find({ deliveryDate: { $lt: currDate } }).populate('items.product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!orders) return res.status(404).json({ message: 'No upcoming orders' });
    return res.status(200).json(orders);
}

exports.upcomingOrders = async (req, res) => {
    const currDateEnd = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDateEnd.setHours(23, 59, 59, 999);
    const orders = await Order.find({ deliveryDate: { $gt: currDateEnd } }).populate('items.product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!orders) return res.status(404).json({ message: 'No upcoming orders' });
    return res.status(200).json(orders);
}


exports.userOrders = async (req, res) => {
    const userOrders = await Order.find({ user: req.auth.id }).populate('items.product')
    if (!userOrders) return res.status(404).json({ message: 'No orders' });
    return res.status(200).json(userOrders);
}

exports.updateDeliveryStatus = async (req, res) => {
    const { deliveryStatus } = req.body;
    const order = await Order.findByIdAndUpdate(req.params.id, {
        $set: {
            deliveryStatus: deliveryStatus
        }
    }, { new: true });
    if (!order) return res.status(404).json({ message: 'Order not found.' });
    return res.status(200).json(order);
}

exports.updateDeliveryDate = async (req, res) => {
    const { deliveryDate } = req.body;
    const order = await Order.findByIdAndUpdate(req.params.id, {
        $set: {
            deliveryDate: new Date(deliveryDate),
        }
    }, { new: true });
    if (!order) return res.status(404).json({ message: 'Order not found.' });
    return res.status(200).json(order);
}

exports.updatePackaged = async (req, res) => {
    const { packaged } = req.body;
    const order = await Order.findByIdAndUpdate(req.params.id, {
        $set: {
            packaged: packaged
        }
    }, { new: true });
    if (!order) return res.status(404).json({ message: 'Order not found.' });
    return res.status(200).json(order);
}

exports.paymentDone = async (req, res) => {
    // delete the order and add each item to history
    const session = await mongoose.startSession()
    session.startTransaction()
    try {
        const currDate = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
        const order = await Order.findByIdAndDelete(req.params.id, { session: session });
        for (let i = 0; i < order.items.length; i++) {
            const history = new History({
                user: order.user,
                product: order.items[i].product,
                quantity: parseInt(order.items[i].quantity),
                date: currDate,
                orderId: order._id,
            });
            await history.save({ session: session });
        }
        await session.commitTransaction();
        session.endSession();
        return res.status(200).json({ message: "Payment successsfull" })
    } catch (ex) {
        await session.abortTransaction();
        session.endSession();
        return res.status(400).json({ message: "Error operation couldnot be performed" });
    }
}

//following are used in frontend
exports.addOrder = async (req, res) => {
    const session = await mongoose.startSession()
    session.startTransaction()
    try {
        const { items, totalPrice, userLocation, deliveryDate, customAddress } = req.body;
        await Cart.findOneAndUpdate({ "user": req.auth.id }, {
            $set: {
                items: [],
                totalPrice: 0.0,
            }
        }, { session: session });
    

        let newDate = new Date(String(deliveryDate));
        const { error } = validate({ items, totalPrice, userLocation, deliveryDate: newDate, customAddress });
        if (error) throw error.details[0].message;
        const order = new Order({
            user: req.auth.id,
            items,
            totalPrice,
            deliveryDate: newDate,
            userLocation,
            customAddress: customAddress,
        });
        const orderData = await order.save({ session: session });
        await session.commitTransaction();
        session.endSession();
        return res.status(200).json(orderData)
    } catch (ex) {
        await session.abortTransaction();
        session.endSession();
        return res.status(400).json(ex);
    }
}

exports.deleteOrder = async (req, res) => {
    const order = await Order.findByIdAndRemove(req.params.id);
    if (!order) return res.status(404).json({ message: 'Order not found.' });
    return res.status(200).json({ message: 'The order was deleted!' });
}

exports.userOrdersUnpacked = async (req, res) => {
    const userOrders = await Order.find({ user: req.auth.id, packaged: false }).populate('items.product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!userOrders) return res.status(404).json({ message: 'No Pending Orders' });
    return res.status(200).json(userOrders);
}

exports.userOrderHistory = async (req, res) => {
    const userOrders = await Order.find({ user: req.auth.id, deliveryStatus: 'Delivered' }).populate('items.product').populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!userOrders) return res.status(404).json({ message: 'No orders' });
    return res.status(200).json(userOrders);
}
