const express = require("express");
const userRoutes = express.Router();
const { getAdmin, getAdminInfos, logout } = require("../controllers/userControllers");
const { getAllEtudiants, getDashboard, getOneEtudiant } = require("../controllers/etudiantControllers");

userRoutes.post("/login", getAdmin);
userRoutes.get("/admin", getAdminInfos);
userRoutes.get("/logout", logout);

userRoutes.get("/etudiants", getAllEtudiants);
userRoutes.get("/etudiant/:id", getOneEtudiant);
userRoutes.get("/dashboard", getDashboard);
module.exports = userRoutes;