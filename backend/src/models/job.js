const mongoose = require("mongoose");
const Joi = require("joi");
Joi.objectId = require('joi-objectid')(Joi)

const jobSchema = mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
        unique: true,
    },
    email: {
        type: String,
        default: ""
    },
    phone: {
        type: Number,
        trim: true,
        unique: true,
        default: 0,
    },
    address: {
        type: String,
        requried: true,
    },
    post: {
        type: String,
        required: true,
    },
    parttime: {
        type: Boolean,
        default: false,
    },
    age: {
        type: Number,
        required: true,
    },
    //skills => tractor driving, grafting, accounting, marketing, planting, bonsai making, pot making, floriculture, cooking, decoration
    skills: {
        type: Array,
        required: true,
    },
    verification: {
        type: Boolean,
        default: false,
    },
    visitdate: {
        type: Date,
    }
}, { timestamps: true });

module.exports.validate = function (job) {
    const schema = Joi.object({
        user: Joi.objectId(),
        email: Joi.string(),
        phone: Joi.number(),
        address: Joi.string().required(),
        parttime: Joi.bool().required(),
        post: Joi.string().required(),
        age: Joi.number().required(),
        skills: Joi.array().required()
    });
    const result = schema.validate(job);
    return result;
}
module.exports.Job = mongoose.model("Job", jobSchema);