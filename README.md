Software Engineering API - Flask API
This project is a Flask-based API designed to provide information about students and subjects associated with a Software Engineering program. The API includes two main endpoints:

/students: Provides a list of students and their enrolled programs.

/subjects: Lists subjects for the Software Engineering program, organized by academic year.

🌐 API Live Links:

http://16.171.47.18:5000/subjects

http://16.171.47.18:5000/students

Bash Scripts (bash_scripts/ Directory)
This folder contains Bash scripts to help monitor, back up, and maintain the API server.

1. health_check.sh
Checks CPU, memory, and disk usage.

Verifies the web server is running.

Tests /students and /subjects API endpoints.

Logs status to /var/log/server_health.log.

2. backup_api.sh
Backs up the API project files and MySQL database.

Archives are stored in ~/backups.

Automatically deletes backups older than 7 days.

Logs status to /var/log/backup.log.

3. update_server.sh
Updates Ubuntu packages.

Pulls the latest changes from GitHub.

Restarts the web server.

Logs to /var/log/update.log.

How to Use Bash Scripts:
bash
Copy
Edit
# Make scripts executable
chmod +x bash_scripts/*.sh

# Run a script
./bash_scripts/health_check.sh
Docker Deployment
Building Docker Images
Inside your project directory (katunzi-api/):

bash
Copy
Edit
# Build the Docker images using Docker Compose
sudo docker-compose build
This will create:

cs421-assignment-api:latest — Your Flask API container.

mysql:8.0 — The MySQL database container.

Running the Containers
bash
Copy
Edit
# Run containers in the background
sudo docker-compose up -d
You can view running containers with:

bash
Copy
Edit
docker ps
Viewing Container Logs
bash
Copy
Edit
docker logs <container_name>
Example:

bash
Copy
Edit
docker logs cs421-assignment-api
Docker Registry Upload
1. Tag Your Image (if needed)
If you have not already tagged:

bash
Copy
Edit
docker tag cs421-assignment-api thedeveloperdesk/cs421-assignment3:v1
2. Login to Docker Hub
bash
Copy
Edit
docker login
Enter your Docker Hub username and password.

3. Push the Image
bash
Copy
Edit
docker push hamisishehe05/hamisi-api:latest
✅ This uploads your image to Docker Hub.

Docker Hub Link
You can pull the image using:

bash
Copy
Edit
docker pull thedeveloperdesk/cs421-assignment3:v1
Or view it on Docker Hub:
👉 https://hub.docker.com/repository/docker/thedeveloperdesk/cs421-assignment3




Troubleshooting Tips and Problem	Solution
->Error starting userland proxy: listen tcp4 0.0.0.0:3306: bind: address already in use	MySQL is already running on port 3306. Stop it: sudo systemctl stop mysql
->denied: requested access to the resource is denied	You forgot to docker login before pushing images.
->Flask server accessible on localhost but not public IP	Make sure Flask binds to 0.0.0.0 and EC2 Security Group allows port 8000 or 5000.
Docker Compose not recognized	Install Docker Compose: sudo apt install docker-compose


Project Dependencies
Make sure these are installed on the server:

curl

tar

mysqldump (or your database client)

git

docker

docker-compose
