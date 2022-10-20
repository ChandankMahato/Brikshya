const mongoose = require("mongoose");
const Joi = require("joi");
const { date, string } = require("joi");

const eventSchema = mongoose.Schema({
    title: {
        type: String,
        required: true,
    },
    image: {
        type: String,
        required: true,
    },
    date: {
        type: Date,
        required: true,
    },
    location: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        default: ""
    },
    type: {
        type: String,
        default: "free"
    },
    registeredUsers: {
        type: Array,
    },
    totalOutcome: {
        type: Number,
        default: 0,
    }
}, { timestamps: true });

module.exports.validate = function (event) {
    const schema = Joi.object({
        title: Joi.string().min(2).required().max(500),
        image: Joi.string().required(),
        date: Joi.date().required(),
        location: Joi.string().required(),
        type: Joi.string(),
    });

    const result = schema.validate(event);
    return result;
  }

module.exports.Event = mongoose.model("Event", eventSchema);