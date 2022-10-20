const express = require('express');
const router = express.Router();
const auth = require('./../middleware/auth')
const { admin } = require('./../middleware/roles')
const { addTrainingRequest, getTrainingRequest, verifyTrainingRequest, cancleTrainingRequest, getAllTrainingRequest } = require('../controllers/trainingController');


router.post('/add/', auth, addTrainingRequest);
router.get('/get/', auth, getTrainingRequest);
router.get('/alltraining', auth, admin, getAllTrainingRequest);
router.put('/verify/:id', verifyTrainingRequest);
router.delete('/cancle/:id', auth, cancleTrainingRequest);

module.exports = router;