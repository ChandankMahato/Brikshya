const { allEvents, freeEvents, todayEvents, paidEvents, finishedFreeEvents, finishedPaidEvents, userRegisteredEvents, finishedEvents, addEvent, updateParticulatEvent, deleteEvent, upcomingEvents, upcomingPaidEvents, upcomingFreeEvents, registerUser, unregisterUser, todaysFreeEvents, userRegisteredUpcomingEvents, userRegisteredFinishedEvents, increaseEventOutcome } = require("../controllers/eventController")
const express = require('express');
const router = express.Router();
const auth = require('./../middleware/auth')
const { admin, user } = require('./../middleware/roles')

router.get('/', allEvents);
router.get('/upcoming', upcomingEvents);
router.get('/history', finishedEvents);
router.get('/today', todayEvents);

router.get('/free', auth, freeEvents);

router.get('/myevents/', auth, user, userRegisteredEvents);

// admin middleware
router.post('/add', auth, admin, addEvent);
router.put('/update/:id', auth, admin, updateParticulatEvent);
router.put('/update/increase/count/:id', auth, admin, increaseEventOutcome);
router.delete('/delete/:id', auth, admin, deleteEvent);

router.get('/upcoming/free', auth, upcomingFreeEvents);
router.get('/history/free', auth, finishedFreeEvents);
router.get('/today/free', auth, todaysFreeEvents);

router.put('/register/:id', auth, user, registerUser);
router.put('/unregister/:id', auth, user, unregisterUser);
router.get('/registered/upcoming/', auth, user, userRegisteredUpcomingEvents);
router.get('/registered/history/', auth, user, userRegisteredFinishedEvents);

//paid
router.get('/history/paid', auth, finishedPaidEvents);
router.get('/paid', auth, paidEvents);
router.get('/upcoming/paid', auth, upcomingPaidEvents);

module.exports = router;