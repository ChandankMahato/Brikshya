const express = require('express');
const router = express.Router();
const auth = require('./../middleware/auth')
const { admin } = require('./../middleware/roles')
const { addJobRequest, getJobRequest, verifyJobRequest, cancleJobRequest, getAllJobRequest, getVaccancy, addVaccancy, deleteVaccancy } = require('../controllers/jobController');


router.post('/add/', auth, addJobRequest);
router.get('/get/', auth, getJobRequest);
router.put('/verify/:id', verifyJobRequest);
router.delete('/cancle/:id', auth, cancleJobRequest);
router.get('/alljob', auth, admin, getAllJobRequest);

router.post('/add/vaccancy', auth, admin, addVaccancy);
router.delete('/delete/vaccancy', auth, admin, deleteVaccancy);
router.get('/get/vaccancy', auth, getVaccancy);

module.exports = router;