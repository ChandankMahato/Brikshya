const mongoose = require('mongoose');
const Joi = require("joi");
Joi.objectId = require('joi-objectid')(Joi)

const historySchema = new mongoose.Schema({
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
    quantity: {
        type: Number,
        required: true,
    },
    orderId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
    },
    date: {
        type: Date,
        required: true,
    }
}, { timestamps: true });

module.exports.validate = function (history) {
    const schema = Joi.object({
        product: Joi.objectId().required(),
        quantity: Joi.number().required(),
    });
    const result = schema.validate(history);
    return result;
}

module.exports.History = mongoose.model('History', historySchema);