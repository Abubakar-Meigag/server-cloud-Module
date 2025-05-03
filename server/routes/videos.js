const express = require("express");
const router = express.Router();

const getVideos = require("../end-points/getVideos");
const postVideo = require("../end-points/postVideo");
const deleteVideo = require("../end-points/deleteVideo");

router.get("/", getVideos);
router.post("/", postVideo);
router.delete("/:id", deleteVideo);

module.exports = router;