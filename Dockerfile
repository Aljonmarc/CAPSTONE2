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
EXPOSE 10000

# Ensure the container listens on the correct port
ENV PORT=10000

# Serve the app after the build
CMD ["npm", "run", "serve"]  # This will run "vite preview" to serve the production build
