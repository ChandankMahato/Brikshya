
const { Training, validate } = require("../models/training");

exports.addTrainingRequest = async (req, res) => {
    const { error } = validate(req.body);
    if (error) {
        return res.status(400).json({ message: error.details[0].message });
    }
    const { email, phone, address, training, age } = req.body;
    const trainingData = new Training({
        user: req.auth.id,
        email,
        phone,
        address,
        training,
        age,
        visitdate: new Date()
    });
    await trainingData.save();
    res.status(200).json(training);
}

exports.getAllTrainingRequest = async (req, res) => {
    const trainings = await Training.find({}).populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    },);
    if (!trainings) return res.status(404).json({ message: 'No training request' });
    return res.status(200).json(trainings);
}

exports.getTrainingRequest = async (req, res) => {
    const trainings = await Training.find({ "user": req.auth.id }).populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    },);
    if (!trainings) return res.status(404).json([]);
    return res.status(200).json(trainings);
}

exports.verifyTrainingRequest = async (req, res) => {
    const { visitdate } = req.body;
    let newDate = new Date(String(visitdate));
    const updateTraning = await Training.findOneAndUpdate({ "_id": req.params.id }, {
        $set: {
            visitdate: newDate,
            verification: true
        }
    }, { new: true });
    if (!updateTraning) return res.status(404).json({ message: 'Training not found' });
    res.status(200).json('Training Updated!');
}

exports.cancleTrainingRequest = async (req, res) => {
    const training = await Training.findByIdAndRemove(req.params.id);
    if (!training) return res.status(404).json({ message: 'Training not found' });
    return res.status(200).json({ message: 'The training request was deleted!' });
}