const { userFavourites, addUserFavourites, resolveFavourites, addUpdateUserFavourites, userFavouriteItemList } = require("../controllers/favouriteController") 
const express = require('express');
const router = express.Router();
const auth = require('./../middleware/auth')
const { user } = require('./../middleware/roles')

router.get('/', auth, user,  userFavourites)
router.put('/addupdate', auth, user, addUpdateUserFavourites)
router.put('/resolve', auth, user, resolveFavourites)

module.exports = router;
