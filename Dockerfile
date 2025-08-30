# Use the official Flutter image as base
FROM ghcr.io/cirruslabs/flutter:stable

# Set working directory
WORKDIR /app

# Copy pubspec files
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Build the Flutter web app
RUN flutter build web

# Use nginx to serve the Flutter web app
FROM nginx:alpine

# Copy the built Flutter web app to nginx
COPY --from=0 /app/build/web /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
