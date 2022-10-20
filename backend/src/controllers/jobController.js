const { Job, validate } = require("../models/job");
const { Vaccancy } = require("../models/vaccancy");

exports.addJobRequest = async (req, res) => {
    const { error } = validate(req.body);
    if (error) {
        return res.status(400).json({ message: error.details[0].message })
    };

    const { email, phone, address, post, parttime, age, skills } = req.body;

    const job = new Job({
        user: req.auth.id,
        email,
        phone,
        address,
        post,
        parttime,
        age,
        skills,
        visitdate: new Date()
    });
    await job.save();
    res.status(200).json(job);
}

exports.getAllJobRequest = async (req, res) => {
    const jobs = await Job.find({}).populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    },);
    if (!jobs) return res.status(404).json({ message: 'No job request' })
    return res.status(200).json(jobs);
}

exports.getJobRequest = async (req, res) => {
    const jobs = await Job.find({ "user": req.auth.id }).populate({
        path: "user",
        select: {
            phoneNumber: 1,
            name: 1,
            _id: -1,
        }
    },);

    if (!jobs) {
        return res.status(404).json([]);
    }
    return res.status(200).json(jobs);
}

exports.verifyJobRequest = async (req, res) => {
    const { visitdate } = req.body;
    let newDate = new Date(String(visitdate));
    const updateJob = await Job.findOneAndUpdate({ "_id": req.params.id }, {
        $set: {
            visitdate: newDate,
            verification: true
        }
    }, { new: true });
    if (!updateJob) return res.status(404).json({ message: 'Job not found' });
    res.status(200).json('Job Updated!');
}

exports.cancleJobRequest = async (req, res) => {
    const job = await Job.findByIdAndRemove(req.params.id);
    if (!job) return res.status(404).json({ message: 'Job not found' });
    return res.status(200).json({ message: 'The job request was deleted!' });
}


exports.addVaccancy = async (req, res) => {
    const { job, training } = req.body;
    const vaccancy = new Vaccancy({
        job,
        training,
    });
    const newVaccancy = await vaccancy.save();
    if (!newVaccancy) return res.status(404).json({ message: 'vaccancy not added!' });
    res.status(200).json(newVaccancy);
}

exports.deleteVaccancy = async (req, res) => {
    const vaccancy = await Vaccancy.remove();
    if (!vaccancy) return res.status(404).json({ message: 'vaccancy not found' });
    return res.status(200).json({ message: 'The vaccancy request was deleted!' });
}

exports.getVaccancy = async (req, res) => {
    const vaccancy = await Vaccancy.find();
    if (!vaccancy) return res.status(404).json([]);
    return res.status(200).json(vaccancy);
}