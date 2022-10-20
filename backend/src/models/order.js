const mongoose = require("mongoose");
const Joi = require("joi");
Joi.objectId = require('joi-objectid')(Joi)
    
const orderSchema = mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },
    items: [
        {
            product: {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Product",
                required: true,
            },
            quantity: {
                type: Number,
                required: true,
            },
            _id: false,
        }
    ],
    totalPrice: {
        type: Number,
        default: 0,
        required: true,
    },
    packaged: {
        type: Boolean,
        default: false,
    },
    deliveryStatus: {
        type: String,
        enum: ['Pending', 'Delivered', 'Returned To Sender'],
        default: "Pending"
    },
    // set delivery date such that the delivery day is saturday
    // if saturday is less than 4 days away set delivery date to next saturday
    // else set this saturday as delivery date
    // either way delivery date must be atleast 4 days and atmost 11 days from the date of checkout
    deliveryDate: {
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
    },
}, { timestamps: true });

module.exports.validate = function (cart) {
    const schema = Joi.object({
        user: Joi.objectId(),
        items: Joi.array().required(),
        packaged: Joi.boolean(),
        totalPrice: Joi.number().required(),
        deliveryDate: Joi.date().required(),
        userLocation: Joi.object().required(),
        customAddress: Joi.string(),
    });

    const result = schema.validate(cart);
    return result;
  }

module.exports.Order = mongoose.model("Order", orderSchema);