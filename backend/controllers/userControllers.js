const pool = require("../database/mysql");
const jwt = require("jsonwebtoken");
// const { signupError } = require("../Utils/ErrorsUtil");
const maxAge = 24 * 3600 * 1000; // 24 heures en millisecondes

let CreateToken = (id) => {
  return jwt.sign({ userId: id }, process.env.JWT_SECRET, {
    expiresIn: "24h",
  });
};
module.exports.getAdmin = async (req, res) => {
    try{
     const { email, password } = req.body;
        const data = await pool.query('SELECT * FROM admin WHERE email = ? AND password = ?', [email, password]);
        if (data[0].length === 0) {
            return res.status(404).json({ error: 'admin not found' });
        }
        const admin = data[0][0];
    // res.send(JSON.stringify(admin));
        const token =CreateToken(admin.id);
    res.cookie("jwt", token, {
        httpOnly: true,
        maxAge: maxAge,
    });
        // Logique de connexion de l'utilisateur (ex: vérification des informations d'identification)
        res.status(200).json({ message: 'User logged in successfully' ,admin: admin});
}catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Login failed' });
    }  
};