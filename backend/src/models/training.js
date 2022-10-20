const mongoose = require('mongoose');
const Joi = require("joi");
Joi.objectId = require('joi-objectid')(Joi)

const trainingSchema = new mongoose.Schema({
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
    training: {
        type: String,
        required: true,
    },
    age: {
        type: Number,
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
        training: Joi.string().required(),
        address: Joi.string().required(),
        age: Joi.number().required(),   
    })
    const result = schema.validate(job);
    return result;
}
module.exports.Training = mongoose.model("Training", trainingSchema);