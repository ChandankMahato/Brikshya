const mongoose = require('mongoose');
const Joi = require("joi");
Joi.objectId = require('joi-objectid')(Joi)

const productSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
        unique: true,
        minlength: 2,
        maxlength: 500,
    },
    category: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Category",
        required: true,
    },
    image: {
        type: String,
        required: true,
    },
    price: {
        type: Number,
        required: true,
        trim: true,
    },
    description: {
        type: String,
        required: true,
    },
    stock: {
        type: Number,
        default: 0,
    },
    minimum: {
        type: String,
        default: "no"
    },
    rate: {
        type: String,
        default: "no"
    },
    showUser: {
        type: Boolean, 
        default: true 
    },
    askUser: {
        type: Boolean,
        default: false,
    }
}, { timestamps: true });

module.exports.validate = function (product) {
    const schema = Joi.object({
        name: Joi.string().min(2).required().max(500),
        description: Joi.string().required(),
        image: Joi.string().required(),
        price: Joi.number().required(),
        minimum: Joi.string(),
        rate: Joi.string(),
        category: Joi.objectId().required(),
        stock: Joi.number(),
    });

    const result = schema.validate(product);
    return result;
}

module.exports.Product = mongoose.model('Product', productSchema);