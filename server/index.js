// require("dotenv").config()
const express = require("express");
const app = express();
const videoRoutes = require("./routes/videos");

const cors = require("cors");
const port = process.env.PORT || 6006;
const bodyParser = require("body-parser");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());
app.use("/api/videos", videoRoutes);

if (!process.env.DB_URL) {
  throw new Error("DB_URL is not defined!");
}

app.listen(port, () => {
  console.log(`Server is running on Port: ${port}`);
});

app.get("/", (req, res) => {
  res.send(`<h1> Welcome to CYF New cloud module server - backend server week 4 adding terraform with ansibal ✅</h1>`);
});