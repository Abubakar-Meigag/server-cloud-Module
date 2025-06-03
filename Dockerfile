FROM node:22-alpine

WORKDIR  /server

COPY server/package*.json ./

RUN npm install

COPY ./server .
# COPY server/.env .env

EXPOSE 6006

CMD [ "npm", "start" ]