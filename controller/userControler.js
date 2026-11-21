import { prisma } from "../config/config.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

//register
export const RegisterUser = async (req, res) => {
  const { username, password, role } = req.body;
  const hash = await bcrypt.hash(password, 10);
  try {
    const user = await prisma.user.create({
      data: {
        username,
        password: hash,
        role,
      },
    });
    return res.status(201).json({ message: "Akun berhasil dibuat", user });
  } catch (error) {
    return res.status(500).json({
      message: "Internal server error",
      error: error.message,
    });
  }
};
//login
export const LoginUser = async (req, res) => {
  const { username, password } = req.body;
  try {
    const user = await prisma.user.findUnique({ where: { username } });
    if (!user) return res.status(404).json({ message: "User tidak ditemukan" });

    const valid = await bcrypt.compare(password, user.password);
    if (!valid) return res.status(401).json({ message: "Password salah" });

    const token = jwt.sign(
      { id: user.id, username: user.username, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: "8h" },
    );
    return res.json({ token, role: user.role });
  } catch (error) {
    return res.status(500).json({
      message: "Internal server error",
      error: error.message,
    });
  }
};

export const Getuser = async (req, res) => {
  try {
    const data = await prisma.user.findMany();
    return res.status(200).json({
      message: "Data user",
      data,
    });
  } catch (error) {
    return res.status(500).json({
      message: "Internal server error",
      error: error.message,
    });
  }
};

//update use 
export const UpdateUser = async (req,res) => {
  const {username,password}=req.body
  const id =req.params.id
  try {
    const user = await prisma.user.findUnique({
      where:{
        id:Number(id)
      }
    })
    if (!user) {
      return res.status(400).json({
        message:"Gagal update user",
        error:error.message
      })
    }
    const update = await prisma.user.update({
      where:{
        id:Number(id)
      },
      data:{
        username,
        password
      }
    })
    res.status(200).json({
      message:"Update berhasil",
      data:update
    })
  } catch (error) {
    return res.status(500).json({
      message:"Internal server error",
      error:error.message
    })
  }
}