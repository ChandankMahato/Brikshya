const mongoose = require("mongoose");
const vaccancySchema = mongoose.Schema({
    job: {
        type: Array,
    },
    training: {
        type: Array,
    },
}, { timestamps: true });

module.exports.Vaccancy = mongoose.model("Vaccancy", vaccancySchema);