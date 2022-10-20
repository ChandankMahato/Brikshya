const { allHistory, userHistory, dataForGraph } = require("../controllers/historyController")
const express = require('express');
const router = express.Router();
const auth = require('./../middleware/auth')
const { admin, user } = require('./../middleware/roles')

router.get('/', auth, admin, allHistory);
router.get('/data/graph', auth, admin, dataForGraph);

// in frontend show the history date by using created at
//user
router.get('/user', auth, user, userHistory);

module.exports = router;