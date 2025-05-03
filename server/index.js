require("dotenv").config();
const express = require("express");
const app = express();

const cors = require("cors");
const port = process.env.PORT || 6006;
const pool = require("./database/db");
const bodyParser = require("body-parser");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());
// pool.connect();

app.listen(port, () => {
  console.log(`Server is running on Port: ${port}`);
});

app.get("/", (req, res) => {
  res.send(`Welcome to cloud module server  ${port}`);
});


const getVideos = require("./end-points/getVideos");
const postVideo = require("./end-points/postVideo");
const deleteVideo = require("./end-points/deleteVideo");

app.get("/api/videos", getVideos);
app.post("/api/addVideos", postVideo);
app.delete("/api/videos/:id", deleteVideo);

