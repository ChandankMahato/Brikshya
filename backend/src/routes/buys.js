const { allPickedBuys, allPendingBuys, allPendingBuysForToday, allUpcomingPendingBuys, userSellHistory, userPendingSells, addBuyRequest, deleteSellRequest, updatePickUpDate, updatePickedStatus } = require("../controllers/buyController") 
const express = require('express');
const router = express.Router();
const auth = require('./../middleware/auth')
const { admin, user } = require('./../middleware/roles')

router.get('/history', auth, admin, allPickedBuys);
router.get('/pending', auth, admin, allPendingBuys);
router.get('/pending/today', auth, admin, allPendingBuysForToday);
router.get('/pending/upcoming', auth, admin, allUpcomingPendingBuys);

// user sell history
// user
router.get('/history/user', auth, user, userSellHistory);

// user pending sells
//user
router.get('/pending/user', auth, user, userPendingSells);

// add new sell request
//user
router.post('/add', auth, user, addBuyRequest);

// delete sell request with given id
// user
router.delete('/delete/:id', auth, user, deleteSellRequest);

router.put('/update/pickupdate/:id', auth, admin, updatePickUpDate);
router.put('/update/status/picked/:id', auth, admin, updatePickedStatus);

module.exports = router;
