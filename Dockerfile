# Use a Node.js base image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (if present)
COPY package*.json ./ 

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Run the build command for production
RUN npm run build

# Expose the port your app will run on
EXPOSE 4173

# Set the APP_URL environment variable
ENV APP_URL=https://surigao-health-services.onrender.com

# Ensure the container listens on the correct port
ENV PORT=4173

# Run the development server (ensure this is the correct command for your app)
CMD ["npm", "run", "dev"] 