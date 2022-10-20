const express = require('express');
const { signUp, signIn, signOut, userExists, userProfile, changeUserName, changePassword, changePhoneNumber, updateProfileImage } = require('../controllers/userController');
const router = express.Router();
const auth = require('./../middleware/auth')
const { user } = require('./../middleware/roles')

router.post('/signup', signUp);
router.post('/signin', signIn);
router.post('/signout', signOut);
router.get('/exists/:id', userExists);
router.get('/me', auth, user, userProfile);
router.put('/change/username', changeUserName);
router.put('/change/password', changePassword);
router.put('/change/phonenumber', changePhoneNumber);
router.put('/update/profile/', auth, updateProfileImage);

module.exports = router;