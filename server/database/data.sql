
CREATE TABLE videos (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  youtubeId VARCHAR(255) NOT NULL,
  thumbnailUrl VARCHAR(255),
  channelName VARCHAR(255),
  upvotes INT DEFAULT 0,
  downvotes INT DEFAULT 0,
  views INT DEFAULT 0
);

