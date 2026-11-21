import {
  Getuser,
  LoginUser,
  RegisterUser,
  UpdateUser
} from "../controller/userControler.js";
import { isRole, verifyToken } from "../middleware/auth.js";
import express from "express";

export const userRoute = express.Router();

userRoute.post("/register", RegisterUser);
userRoute.post("/login", LoginUser);
userRoute.get("/user", verifyToken, isRole("ADMIN"), Getuser);
userRoute.get("/user", verifyToken, isRole("ADMIN"), UpdateUser);
