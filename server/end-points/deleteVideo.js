const pool = require("../database/db");

const deleteVideo = async (req, res) => {
      const { id } = req.params;

      if (!id || isNaN(id)) {
            return res.status(400).json({
                  status: "fail",
                  message: "A valid ID is required",
            });
      }

      const query = `DELETE FROM videos WHERE id = $1 RETURNING *`;
      const values = [id];

      try {
            const deletedVideo = await pool.query(query, values);
            if (deletedVideo.rows.length > 0) {
                  res.status(200).json({
                        status: "success",
                        message: "Video deleted successfully",
                        data: deletedVideo.rows[0],
                  });
            } else {
                  res.status(404).json({
                        status: "fail",
                        message: "Video not found",
                  });
            }
      } catch (err) {
            console.error("Error deleting video:", err);
            res.status(500).json({
                  status: "error",
                  message: "Internal server error",
            });
      }
}

module.exports = deleteVideo;