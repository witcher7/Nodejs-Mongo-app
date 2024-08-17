apt install npm
npm init -y
npm install express mongoose 


### CODE
const express = require('express');
const mongoose = require('mongoose');

const app = express();

// Connect to MongoDB
mongoose.connect('mongodb://mongo:27017/docker-node-mongo', {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
.then(() => console.log('Connected to MongoDB'))
.catch((err) => console.log(err));

// Define a simple schema and model
const ItemSchema = new mongoose.Schema({
    name: String
});

const Item = mongoose.model('Item', ItemSchema);

// Routes
app.get('/', async (req, res) => {
    const items = await Item.find();
    res.send(items);
});

app.get('/add/:name', async (req, res) => {
    const newItem = new Item({ name: req.params.name });
    await newItem.save();
    res.send('Item added');
});

// Start the server
const PORT = 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));






### DOCKERFILE
# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Run the application
CMD ["node", "app.js"]




#### DOCKER COMPOSE


version: '3.8'

services:
  node:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - mongo

  mongo:
    image: "mongo:latest"
    ports:
      - "27017:27017"
    volumes:
      - mongo-data:/data/db

volumes:
  mongo-data:



