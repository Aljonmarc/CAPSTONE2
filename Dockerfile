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

# Expose the port your app will run on
EXPOSE 4173




# Ensure the container listens on the correct port
ENV PORT=4173

CMD ["npm", "run", "dev"]

