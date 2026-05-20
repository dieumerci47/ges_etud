const pool = require("../database/mysql");
const jwt = require("jsonwebtoken");
// const { signupError } = require("../Utils/ErrorsUtil");
const maxAge = 24 * 3600 * 1000; // 24 heures en millisecondes

let CreateToken = (id) => {
  return jwt.sign({ adminId: id }, process.env.JWT_SECRET, {
    expiresIn: "24h",
  });
};
module.exports.getAdmin = async (req, res) => {
    try{
     const { email, password } = req.body;
    //  console.log(req.body);
    
    const data = await pool.query('SELECT * FROM admin WHERE email = ? AND password = ?', [email, password]);
    //  console.log(data[0]);
        if (data[0].length === 0) {
            console.log("admin not found");
            return res.status(404).json({ error: 'admin not found' });
        }
        const admin = data[0][0];
    // res.send(JSON.stringify(admin));
        const token =CreateToken(admin.id);
    res.cookie("jwt", token, {
        httpOnly: true,
        maxAge: maxAge,
    });
    console.log(`${token} crée`);
    
        // Logique de connexion de l'utilisateur (ex: vérification des informations d'identification)
        res.status(200).json({ message: 'User logged in successfully' ,adminId: admin.id,token:token});
}catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Login failed' });
    }  
};
module.exports.getAdminInfos = async (req, res) => {
    try{
        const { id } = req.body;
     console.log(req.body);
     console.log(id);
     
        const data = await pool.query('SELECT * FROM admin WHERE id = ?', [id]);
        if (data[0].length === 0) {
            console.log("admin not found");
            return res.status(404).json({ error: 'admin not found' });
        }
        const admin = data[0][0];
    // res.send(JSON.stringify(admin));
/*         const token =CreateToken(admin.id);
    res.cookie("jwt", token, {
        httpOnly: true,
        maxAge: maxAge,
    });
    console.log(`${token} crée`); */
    
        // Logique de connexion de l'utilisateur (ex: vérification des informations d'identification)
        // console.log(admin);
        
        res.status(200).json({ message: 'Admin connected' ,admin: admin});
}catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Admin not connected' });
    }  
};

module.exports.logout=(req,res)=>{
    console.log("Deconnecté");
    
    res.cookie("jwt","",{httpOnly:true,maxAge:1})
    res.status(200)
}