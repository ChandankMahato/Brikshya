const express = require('express');
const { categoricalProducts, productById, addProduct, deleteProduct, allProducts, multipleProductDetails, updateAskUser, updateProduct, allListing, allNonListing, updateSellStatus, categoricalNonListings, updateShowUserStatus } = require('../controllers/productController');
const router = express.Router();
const auth = require('./../middleware/auth')
const { admin } = require('./../middleware/roles')

router.get('/category/:id', auth, admin, categoricalProducts);
router.get('/', auth, admin, allProducts);
router.get('/nonlisting', allNonListing);
router.get('/listing', allListing);
router.get('/nonlisting/category/:id', categoricalNonListings);
router.get('/nonlisting', allNonListing);
router.get('/:id', auth, admin, productById);
// admin middleware
router.post('/add', auth, admin, addProduct);
router.delete('/delete/:id', auth, admin, deleteProduct);
router.put('/update/:id', auth, admin, updateProduct);
router.put('/update/askuser/:id', auth, admin, updateAskUser);
router.put('/update/showuser/:id', auth, admin, updateShowUserStatus);



router.post('/multiple/details/', multipleProductDetails);

module.exports = router;