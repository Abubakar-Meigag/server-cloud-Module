FROM node:22-alpine

WORKDIR  /server

COPY server/package*.json ./

RUN npm install

COPY ./server .

EXPOSE 6006

CMD [ "npm", "start" ]