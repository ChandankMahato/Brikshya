const { Category, validate } = require('../models/category');

exports.allCategories = async (req, res) => {
    const categories = await Category.find({'title': {$ne: 'Listing'}});
    if (!categories) return res.status(404).json({ message: 'No added categories' });
    return res.status(200).json(categories);
}



exports.addCategory = async (req, res) => {
    const { error } = validate(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const { title, image } = req.body;
    const catgeory = new Category({
        title,
        image,
    });
    await catgeory.save();
    res.status(200).json(catgeory);
}

exports.categoryDetails = async (req, res) => {
    const category = await Category.find({ "_id": req.params.id });
    if (!category) return res.status(404).json({ message: 'No category with given id' });
    return res.status(200).json(category);
}

exports.deleteCategory = async (req, res) => {
    const category = await Category.findByIdAndRemove(req.params.id);
    if (!category) return res.status(404).json({ message: 'Category not found.' });
    return res.status(200).json({ message: 'The category was deleted!' });
}