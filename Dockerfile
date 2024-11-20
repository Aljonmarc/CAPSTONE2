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
RUN npm run build  # This will use the 'build' script you defined in package.json

# Expose the port your app will run on (optional, depending on your app)
EXPOSE 3000

# Start the application
CMD ["npm", "run", "dev"]  # This starts the dev server; adjust if you're deploying for production
