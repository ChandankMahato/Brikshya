const mongoose = require('mongoose');
const Joi = require("joi");
Joi.objectId = require('joi-objectid')(Joi)

const favouriteSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
        unique: true,
    },
    items: [
        {
            product: {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Product",
                required: true,
            },
            _id : false,
        }
    ],
}, { timestamps: true });

module.exports.validate = function (favourite) {
    const schema = Joi.object({
        user: Joi.objectId(),
        items: Joi.array().required(),
    });
    const result = schema.validate(favourite);
    return result;
}

module.exports.Favourite = mongoose.model('Favourite', favouriteSchema);