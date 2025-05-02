const pool = require("../database/db");

const postVideo = async (req, res) => {
      const { title, youtubeId } = req.body;
      
      if (!title || !youtubeId) {
            return res.status(400).json({
                  status: "fail",
                  message: "All fields are required",
            });
      }

      const query = `
      INSERT INTO videos (title, youtubeId, thumbnailUrl, channelName)
      VALUES ($1, $2, $3, $4)
      RETURNING *`;
    const values = [
      title,
      youtubeId,
      `https://img.youtube.com/vi/${youtubeId}/mqdefault.jpg`,
      "Added by User",
    ];

      try {
            const newVideo = await pool.query(query, values);
            res.status(201).json({
                  status: "success",
                  data: newVideo.rows[0],
            });
      } catch (err) {
            console.error(err);
            res.status(500).json({
                  status: "error",
                  message: "Internal server error",
            });
      }
}

module.exports = postVideo;