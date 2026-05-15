const pool = require("./mysql");

const connectDB = async () => {
    try {
        await pool.getConnection();
        console.log("Connecté à la base de données");
    } catch (error) {
        console.log(error);
    }
}

module.exports = connectDB;