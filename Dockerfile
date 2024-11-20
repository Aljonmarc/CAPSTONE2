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

# Build the app for production
RUN npm run build  # This will use the 'build' script you defined in package.json

# Expose the port your app will run on
EXPOSE 4173  # Port 4173 is detected by Render

# Run the preview (serve) command in production
CMD ["npm", "run", "preview"]  # 'preview' is used in Vite for serving the built app
