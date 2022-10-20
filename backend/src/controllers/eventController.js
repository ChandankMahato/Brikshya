const { Event, validate } = require('../models/event');
const moment = require('moment-timezone');

//admin app uses following...
exports.allEvents = async (req, res) => {
    const currDate = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDate.setHours(0, 0, 0, 0);
    const events = await Event.find({ date: {$gte: currDate} });
    if (!events) return res.status(404).json({ message: 'No events' });
    return res.status(200).json(events);
}

exports.freeEvents = async (req, res) => {
    const events = await Event.find({ type: "free" });
    if (!events) return res.status(404).json({ message: 'No free events' });
    return res.status(200).json(events);
}

exports.upcomingEvents = async (req, res) => {
    const currDateEnd = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDateEnd.setHours(23, 59, 59, 999);
    const events = await Event.find({ date: { $gt: currDateEnd } }).sort({date: 1});
    if (!events) return res.status(404).json({ message: 'No upcoming events' });
    return res.status(200).json(events);
}

exports.todayEvents = async (req, res) => {
    const currDate = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDate.setHours(0, 0, 0, 0);
    const currDateEnd = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDateEnd.setHours(23, 59, 59, 999);
    const events = await Event.find({ date: { $gte: currDate, $lte: currDateEnd } }).sort({date: 1});
    if (!events) return res.status(404).json({ message: 'No upcoming events' });
    return res.status(200).json(events);
}

exports.userRegisteredEvents = async (req, res) => {
    const userEvents = await Event.find({ registeredUsers: req.auth.id })
    if (!userEvents) return res.status(404).json({ message: 'No events' });
    return res.status(200).json(userEvents);
}

exports.userRegisteredUpcomingEvents = async (req, res) => {
    const currDate = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDate.setHours(0, 0, 0, 0);
    const userEvents = await Event.find({ registeredUsers: req.auth.id, date: { $gt: currDate } })
    if (!userEvents) return res.status(404).json({ message: 'No events' });
    return res.status(200).json(userEvents);
}

exports.increaseEventOutcome = async (req, res) => {
    const { by } = req.body;
    const updatedEvent = await Event.findOneAndUpdate({ "_id": req.params.id }, {
        $inc: {
            totalOutcome: by
        }
    }, { new: true });
    if(!updatedEvent) return res.status(404).json({ message: 'Event not found.' });
    res.status(200).json(updatedEvent);
}

exports.userRegisteredFinishedEvents = async (req, res) => {
    const currDate = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDate.setHours(0, 0, 0, 0);
    const userEvents = await Event.find({ registeredUsers: req.auth.id, date: { $lt: currDate } })
    if (!userEvents) return res.status(404).json({ message: 'No events' });
    return res.status(200).json(userEvents);
}

exports.finishedEvents = async (req, res) => {
    const currDate = moment.tz('Asia/Kathmandu').add(345, 'minutes').toDate();
    currDate.setHours(0, 0, 0, 0);
    const events = await Event.find({ date: { $lt: currDate } });
    if (!events) return res.status(404).json({ message: 'No finished events' });
    return res.status(200).json(events);
}

exports.addEvent = async (req, res) => {
    const { error } = validate(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const { title, date, location, type, image } = req.body;

    const event = new Event({
        title,
        image,
        date: new Date(date),
        location,
        type
    });
    await event.save();
    res.status(200).json(event);
}

exports.updateParticulatEvent = async (req, res) => {
    const { title, date, location, totalOutcome } = req.body;

    const updatedEvent = await Event.findOneAndUpdate({ "_id": req.params.id }, {
        $set: {
            title: title,
            date: new Date(date),
            location: location,
            totalOutcome: totalOutcome,
        }
    }, { new: true });
    if(!updatedEvent) return res.status(404).json({ message: 'Event not found.' });
    res.status(200).json(updatedEvent);
}

exports.deleteEvent = async (req, res) => {
    const event = await Event.findByIdAndRemove(req.params.id);
    if (!event) return res.status(404).json({ message: 'Event not found.' });
    return res.status(200).json({ message: 'The event was deleted!' });
}

//frontend user Free events uses following...
exports.upcomingFreeEvents = async (req, res) => {
    const events = await Event.find({ date: { $gt: new Date() }, type: "free" });
    if (!events) return res.status(404).json({ message: 'No upcoming free events' });
    return res.status(200).json(events);
}

exports.finishedFreeEvents = async (req, res) => {
    const events = await Event.find({ date: { $lt: new Date() }, type: "free" });
    if (!events) return res.status(404).json({ message: 'No finished free events' });
    return res.status(200).json(events);
}

exports.registerUser = async (req, res) => {
    const event = await Event.findByIdAndUpdate(req.params.id, {
        $push: {
            registeredUsers: req.auth.id
        }
    }, { new: true })
    if (!event) return res.status(404).json({ message: 'Event not found.' });
    return res.status(200).json({ message: 'The user was registered!' });
}

exports.unregisterUser = async (req, res) => {
    const event = await Event.findByIdAndUpdate(req.params.id, {
        $pull: {
            registeredUsers: req.auth.id

        }
    }, { new: true })
    if (!event) return res.status(404).json({ message: 'Event not found.' });
    return res.status(200).json({ message: 'The user was unregistered!' });
}

//paid
exports.paidEvents = async (req, res) => {
    const events = await Event.find({ type: "paid" });
    if (!events) return res.status(404).json({ message: 'No paid events' });
    return res.status(200).json(events);
}

exports.upcomingPaidEvents = async (req, res) => {
    const events = await Event.find({ date: { $gt: new Date() }, type: "paid" });
    if (!events) return res.status(404).json({ message: 'No upcoming paid events' });
    return res.status(200).json(events);
}

exports.finishedPaidEvents = async (req, res) => {
    const events = await Event.find({ date: { $lt: new Date() }, type: "paid" });
    if (!events) return res.status(404).json({ message: 'No finished paid events' });
    return res.status(200).json(events);
}

exports.todaysFreeEvents = async (req, res) => {
    const currDate = new Date(new Date().toISOString().split('T')[0])
    const currDateEnd = new Date(new Date().toISOString().split('T')[0] + 'T23:59:59.99')
    const events = await Event.find({ date: { $gte: currDate, $lte: currDateEnd } }).populate('items.product');
    if (!events) return res.status(404).json({ message: 'No events for today' });
    return res.status(200).json(events);
}