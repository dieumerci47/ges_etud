const express = require("express");
const userRoutes = express.Router();
const { getAdmin } = require("../controllers/userControllers");

userRoutes.post("/login", getAdmin);

module.exports = userRoutes;