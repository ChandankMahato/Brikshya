const { History } = require('../models/history');

exports.allHistory = async (req, res) => { 
    const allHistory = await History.find().sort({ createdAt: -1 }).populate({
        path: "product",
        select: {
            name: 1,
            price: 1,
            _id: -1,
        }
    }).populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!allHistory) return res.status(404).json({ message: 'No history' });
    return res.status(200).json(allHistory);  
}

exports.userHistory = async (req, res) => {
    const userHistory = await History.find({"user": req.auth.id}).sort({ createdAt: -1 }).populate({
        path: "product",
        select: {
            name: 1,
            price: 1,
            _id: -1,
        }
    }).populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    });
    if (!userHistory) return res.status(404).json({ message: 'No history' });
    return res.status(200).json(userHistory);  
}

exports.dataForGraph = async (req, res) => {
    const allHistory = await History.find().populate({
        path: "product",
        select: {
            name: 1,
            price: 1,
            _id: -1,
        }
    });
    if (!allHistory) return res.status(404).json({ message: 'No history' });
    return res.status(200).json(allHistory);  
}
