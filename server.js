import express from "express";
import cors from "cors";
import morgan from "morgan";
import dotenv from "dotenv";
import { userRoute } from "./routes/userRoutes.js";

const app = express();

//middleware
dotenv.config();
app.use(morgan("dev"));
app.use(cors());
app.use(express.json());

// Router
app.use("/api/", userRoute);

app.listen(process.env.PORT, () => {
  console.log(`server running http://localhost:${process.env.PORT}`);
});
