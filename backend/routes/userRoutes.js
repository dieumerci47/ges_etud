const express = require("express");
const userRoutes = express.Router();
const { getAdmin, getAdminInfos, logout } = require("../controllers/userControllers");
const { getAllEtudiants, getDashboard } = require("../controllers/etudiantControllers");

userRoutes.post("/login", getAdmin);
userRoutes.get("/admin", getAdminInfos);
userRoutes.get("/logout", logout);

userRoutes.get("/etudiants", getAllEtudiants);
userRoutes.get("/dashboard", getDashboard);
module.exports = userRoutes;