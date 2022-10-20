const mongoose = require('mongoose');
const Joi = require("joi");
Joi.objectId = require('joi-objectid')(Joi)

const buySchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },

    product: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
        required: true,
    },

    pickedUp: {
        type: Boolean,
        default: false,
    },
    pickupDate: {
        type: Date,
        required: true,
    },
    customAddress: {
        type: String,
        default: "",
    },
    userLocation: {
        type: mongoose.Schema({
            latitude: {
                type: Number,
                required: true,
            },
            longitude: {
                type: Number,
                required: true,
            },
            _id: false
        })
    }
}, { timestamps: true });

module.exports.validate = function (value) {
    const schema = Joi.object({
        product: Joi.objectId().required(),
        user: Joi.objectId(),
        pickupDate: Joi.date().required(),
        userLocation: Joi.object().required(),
        customAddress: Joi.string(),
    });

    const result = schema.validate(value);
    return result;
}

module.exports.Buy = mongoose.model('Buy', buySchema);