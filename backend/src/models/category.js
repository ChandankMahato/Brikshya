const mongoose = require("mongoose");
const Joi = require("joi");

const categorySchema = mongoose.Schema({
    title: {
        type: String,
        required: true,
        unique: true,
    },
    image: {
        type: String,
    }
}, { timestamps: true });

module.exports.validate = function (category) {
    const schema = Joi.object({
        title: Joi.string().min(2).required().max(500),
        image: Joi.string().required(),
    });

    const result = schema.validate(category);
    return result;
  }

module.exports.Category = mongoose.model("Category", categorySchema);