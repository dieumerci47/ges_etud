const jwt = require("jsonwebtoken")
module.exports.authMiddleware = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1]; // "Bearer xxx" → "xxx"
  if (!token) return res.status(401).json({ error: 'Non autorisé' });
  
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
  // A CHANGE PLUS TARD PAR decoded.adminId
    req.adminId = decoded.adminId;
    console.log(`Authentification en cours de ${req.adminId}`);
    
    next();
  } catch (err) {
    console.log(`${token} expiré`);
    
    res.status(401).json({ error: 'Token invalide' });
  }
};