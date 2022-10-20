const { userCart, resolveCart, addUpdateUserCart, userCartTotalPrice } = require("../controllers/cartController") 
const express = require('express');
const router = express.Router();
const auth = require('./../middleware/auth')
const { admin, user } = require('./../middleware/roles')

router.get('/', auth, user, userCart);
router.put('/addupdate/', auth, user, addUpdateUserCart);
router.get('/gettotalprice/', auth, user, userCartTotalPrice);
router.put('/resolve/', auth, user, resolveCart)

module.exports = router;
