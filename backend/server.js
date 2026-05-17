const express = require("express");
require("dotenv").config();
const cors = require("cors");
const connectDB = require("./database/connection");
const userRoutes = require("./routes/userRoutes");
const cookieParser = require("cookie-parser");
const { authMiddleware } = require("./middleware/auth");
const app = express();


  try {
     connectDB();
    //  console.log("yes");
     
  } catch (error) {
    console.log(error);
  }


const PORT = process.env.PORT;
const IP = process.env.IP;

app.use(cors());
app.use(express.json());
app.use(cookieParser())

app.use("/api", userRoutes);
app.get('/api/verify', authMiddleware, (req, res) => {
  console.log(`${req.adminId} a vérrifié`);
  
  res.status(200).json({ valid: true, adminId: req.adminId });
});

app.listen(PORT, IP, () => {
  console.log(`Serveur en cours d'execution sur http://${IP}:${PORT}`);
});