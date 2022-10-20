const mongoose = require("mongoose");
const Joi = require("joi");

const cartSchema = mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        unique: true,
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
                default: 0,   
            },
            _id: false,
        }
    ],
    totalPrice: {
        type: Number,
        default: 0,
        required: true,
    },
}, { timestamps: true });

module.exports.validate = function (cart) {
    const schema = Joi.object({
        user: Joi.objectId(),
        items: Joi.array().required(),
        totalPrice: Joi.number().required(),
    });

    const result = schema.validate(cart);
    return result;
  }

module.exports.Cart = mongoose.model("Cart", cartSchema);