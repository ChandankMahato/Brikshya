const express = require('express')
require("express-async-errors");
const mongoose = require('mongoose')
const env = require('dotenv')
const users = require('./routes/users');
const products = require('./routes/products');
const categories = require('./routes/categories');
const favourites = require('./routes/favourites');
const events = require('./routes/events');
const carts = require('./routes/carts');
const otp = require("./routes/otp");
const job = require('./routes/job');
const training = require('./routes/training');
const orders = require("./routes/orders");
const buys = require("./routes/buys");
const error = require("./middleware/error");
const history = require("./routes/history")
const cors = require("cors");

const app = express();
env.config();

mongoose.connect(
    `mongodb+srv://${process.env.MONGO_DB_USER}:${process.env.MONGO_DB_PASSWORD}@cluster0.yus4n.mongodb.net/${process.env.MONGO_DB_DATABASE}?retryWrites=true&w=majority`,
    {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    }
).then(() => {
    console.log('Database connected');
}).catch((ex) => {
    console.log(ex)
    console.log("Couldnot connect to mongodb");
});


//routes
app.use(express.json());
app.use(cors())
app.use(error);
app.use('/api/user', users)
app.use('/api/product', products)
app.use('/api/category', categories)
app.use('/api/favourite', favourites)
app.use('/api/cart', carts)
app.use('/api/event', events)
app.use('/api/order', orders)
app.use('/api/buy', buys)
app.use('/api/otp', otp)
app.use('/api/job', job);
app.use('/api/training', training);
app.use('/api/history', history)

app.listen(process.env.PORT, () => {
    console.log(`Server is running on port ${process.env.PORT}`);
})