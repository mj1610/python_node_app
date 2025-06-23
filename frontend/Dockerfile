FROM node:20-slim

# Set working directory
WORKDIR /app

# Copy only package files to install dependencies (so npm install can be cached)
COPY package*.json ./

# Install dependencies
RUN npm install

# Now copy the rest of the application code
COPY . .

# Start the app
CMD ["node", "app.js"]
