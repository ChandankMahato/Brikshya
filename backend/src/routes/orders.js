const express = require('express');
const { allOrders, todayOrders, pastOrders, upcomingOrders, paymentDone, addOrder, userOrders, updatePackaged, updateDeliveryStatus, updateDeliveryDate, deleteOrder, userOrdersUnpacked, userOrderHistory } = require('../controllers/orderController');
const router = express.Router();
const auth = require('./../middleware/auth')
const { admin, user } = require('./../middleware/roles')

router.get('/', auth, admin, allOrders);
router.get('/today', auth, admin, todayOrders);
router.get('/history', auth, admin, pastOrders);
router.get('/upcoming', auth, admin, upcomingOrders);



// gives a list of orders of a user
// user
router.get('/user', auth, user, userOrders);

// updates packaged
router.put('/update/orderstatus/:id', auth, admin, updatePackaged);

// updates delivery status
router.put('/update/status/delivery/:id', auth, admin, updateDeliveryStatus);

//update delivery date
router.put('/update/deliverydate/:id', auth, admin, updateDeliveryDate)

// called after user pays the amount
router.put('/payment/done/:id', auth, admin, paymentDone)


// following are used in frontend
router.post('/add', auth, user, addOrder);
router.delete('/delete/:id', auth, deleteOrder)
router.get('/unpacked', auth, user, userOrdersUnpacked);
router.get('/user/history', auth, user, userOrderHistory);

module.exports = router;