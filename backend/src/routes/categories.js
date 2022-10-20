const express = require('express');
const { allCategories, addCategory, categoryDetails, deleteCategory, updateImage } = require('../controllers/categoryController');
const router = express.Router();
const auth = require('./../middleware/auth')
const { admin, user } = require('./../middleware/roles')

router.get('/', allCategories);
router.get('/:id', auth, categoryDetails)
// admin middleware
router.post('/add', auth, admin, addCategory);
router.delete('/delete/:id', auth, admin, deleteCategory);

module.exports = router;