exports.user = (req, res, next) => {
    if (req.auth.role === 'user') {
        next();
    } else {
        res.status(401).json({message: "Access denied"})
    }
}

exports.admin = (req, res, next) => {
    if (req.auth.role === 'admin') {
        next();
    } else {
        res.status(401).json({message: "Access denied"})
    }
}