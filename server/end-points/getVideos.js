const pool = require("../database/db");

const getVideos = async (req, res) => {
      const query = 'SELECT * FROM videos';

      try {
            const videos = await pool.query(query);
            if (videos.rows.length > 0) {
                  res.status(200).json({
                        status: "success",
                        data: videos.rows,
                  });
            } else {
                  res.status(404).json({
                        status: "fail",
                        message: "No videos found",
                  });
            }
      } catch (err) {
            console.error(err);
            res.status(500).json({
                  status: "error",
                  message: "Internal server error",
            });
            
      }
}

module.exports = getVideos;