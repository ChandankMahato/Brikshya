const { User, validate } = require('../models/user');
const env = require('dotenv');
const bcrypt = require("bcrypt");
const { response } = require('express');
env.config();


exports.signUp = async (req, res) => {
    const { error } = validate(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });
    const { phoneNumber, name, role } = req.body;
    const password = await bcrypt.hash(req.body.password, 10);
    const newUser = new User({
        phoneNumber,
        name,
        password,
        role: role ? role : 'user'
    });
    await newUser.save();
    const token = newUser.getAuthenticationToken();
    res.cookie('token', token, { expiresIn: '500hr' });
    res.status(201).json({ token: token, id: newUser._id });
}

exports.signIn = async (req, res) => {
    const user = await User.findOne({ phoneNumber: req.body.phoneNumber });
    if (!user) return res.status(400).json({ message: "Invalid phone number or password" });

    const validPassword = await user.isPasswordValid(req.body.password);
    if (!validPassword) return res.status(400).json({ message: "Invalid phone number or password" });
    const token = user.getAuthenticationToken();
    res.cookie('token', token, { expiresIn: '500hr' });
    res.status(200).json({ token: token, id: user._id });
}

exports.userExists = async (req, res) => {
    const phoneNumber = req.params.id;
    const user = await User.findOne({ "phoneNumber": phoneNumber })
    if (user) return res.status(400).json({ message: "User exists" })
    res.status(200).json({ message: "User doesnot exists" })
}

exports.userProfile = async (req, res) => {
    const user = await User.findById(req.auth.id).select("-password -role")
    if (!user) return res.status(400).json({ message: "User doesnot exist" })
    res.status(200).json(user)
}

exports.updateProfileImage = async (req, res) => {
    const user = await User.findById(req.auth.id);
    if (!user) return res.status(400).json({ message: "User does not exist" });
    const update = await User.findByIdAndUpdate(req.auth.id, {
        $set: {
            image: req.body.image,
        }
    }, { new: true });
    if (!update) return res.status(404).json('Counld not update image!');
    res.status(200).json({ message: 'profile image updated!' });
}

exports.changeUserName = async (req, res) => {
    const { userName, phoneNumber, password } = req.body;
    const user = await User.findOne({ phoneNumber: phoneNumber });
    if (!user) return res.status(400).json({ message: "Invalid phone number or password" });

    const validPassword = await user.isPasswordValid(password);
    if (!validPassword) return res.status(400).json({ message: "Invalid phone number or password" });
    const updated = await User.findOneAndUpdate({ "phoneNumber": phoneNumber }, {
        $set: {
            name: userName,
        }
    }, { new: true });
    if (!updated) return res.status(404).json({ message: 'Could not update username!' });
    res.status(200).json({ message: 'Username updated Successfully!' });
}

exports.changePhoneNumber = async (req, res) => {
    const { newPhoneNumber, phoneNumber, password } = req.body;
    const user = await User.findOne({ phoneNumber: phoneNumber });
    if (!user) return res.status(400).json({ message: "Invalid old phone number or password" });

    const validPassword = await user.isPasswordValid(password);
    if (!validPassword) return res.status(400).json({ message: "Invalid old phone number or password" });
    const updated = await User.findOneAndUpdate({ "phoneNumber": phoneNumber }, {
        $set: {
            phoneNumber: newPhoneNumber,
        }
    }, { new: true });
    if (!updated) return res.status(404).json({ message: 'Could not update phoneNumber!' });
    res.status(200).json({ message: 'Phonenumber updated Successfully!' });
}

exports.changePassword = async (req, res) => {
    const { phoneNumber, newPassword } = req.body;
    const user = await User.findOne({ phoneNumber: phoneNumber });
    if (!user) return res.status(400).json({ message: "Invalid phone number or password" });

    const encryptedPassword = await bcrypt.hash(newPassword, 10);
    const updated = await User.findOneAndUpdate({ "phoneNumber": phoneNumber }, {
        $set: {
            password: encryptedPassword,
        }
    }, { new: true });
    if (!updated) return res.status(404).json({ message: 'Could not update Password!' });
    res.status(200).json({ message: 'Password updated Successfully!' });
}


// no need for api call
exports.signOut = (req, res) => {
    res.clearCookie('token');
    res.status(200).json({
        messsage: 'Signout Successful...!'
    });
}
