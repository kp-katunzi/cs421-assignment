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
docker push thedeveloperdesk/cs421-assignment3:v1
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

Instructions for building and running the front-end containers.

Before start to create the react app make sure you install the following

sudo apt install node
sudo apt install npm

 Create the React Front-End
To create the react_frontend app which handle the frontend by using react
npm create vite@latest react_frontend -- --template react
cd react_frontend

 Install Dependencies (once) In your React project directory (e.g., frontend/):
npm install 

 Build the Production Version

Run:

npm run build

This creates a build/ folder containing:

    index.html

    JavaScript bundles (e.g., main.[hash].js)

    CSS files

    asset manifests (e.g., asset-manifest.json)

    images, fonts, etc.

To test if the framework are working properly run 
npm run dev

T o create the react pages which will interact with the API 

The Dockerfile in react_fontend


 docker-compose.yml  which contain multiple Frontends such as 

 frontend1
 frontend2
 frontend3

 Docker Hub
docker tag cs421-assignment_api thedeveloperdesk/cs421-assignment-frontend:latest
docker tag cs421-assignment_frontend3 thedeveloperdesk/cs421-assignment-frontend:latest
docker tag cs421-assignment_frontend2 thedeveloperdesk/cs421-assignment-frontend:latest
docker tag cs421-assignment_frontend1 thedeveloperdesk/cs421-assignment-frontend:latest

ocker pull thedeveloperdesk/cs421-assignment-frontend:latest
Or view it on Docker Hub:
👉 https://hub.docker.com/repository/docker/thedeveloperdesk/cs421-assignment-frontend


 Load balance which creates in the nginx.conf
 as the following
 events {}

http {
    upstream frontend_nodes {
        server frontend1:80;
        server frontend2:80;
        server frontend3:80;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://frontend_nodes;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}


Build & Run All Containers

sudo docker-compose up -d --build


 Access Your Front-End

 frontend1: http://16.171.47.18:3000
frontend2: http://16.171.47.18:3001
frontend3: http://16.171.47.18:3002




Load Balancer Setup with NGINX (Round-Robin & Health Checks)

The load balancer setup in your Docker environment uses NGINX to distribute traffic across multiple React front-end instances using the round-robin algorithm. Additionally, it ensures that only healthy front-end containers handle the requests, which is achieved through health checks.
Key Components of the Load Balancer Setup

    NGINX Configuration (nginx.conf):
    NGINX will load balance the requests to the different React front-end instances and perform health checks to ensure that only healthy instances serve traffic.

    Round-Robin Load Balancing:
    The round-robin algorithm evenly distributes incoming requests across all available back-end services. In the case of your React app, the requests are distributed among frontend1, frontend2, and frontend3 containers.

    Health Checks:
    NGINX has built-in directives for handling health checks. These ensure that if a particular front-end instance fails or becomes unhealthy, it will be skipped by NGINX until it recovers.

1. NGINX Configuration File (nginx.conf)

In your nginx.conf, you'll define the upstream block to specify the React front-end instances (with round-robin distribution), and configure the health checks to ensure only healthy instances are used.

2. Round-Robin Load Balancing

The round-robin algorithm is used by default in NGINX to distribute requests between the available backend servers. The servers are defined in the upstream frontend_servers block, and NGINX automatically cycles through them in order to balance the load.

In the example above:

    frontend1 is accessed via port 3000

    frontend2 is accessed via port 3001

    frontend3 is accessed via port 3002

Each incoming request to the NGINX load balancer will be routed to one of these front-end containers, in a round-robin fashion (i.e., first to frontend1, then to frontend2, and so on).

3. Health Checks

To ensure NGINX routes traffic only to healthy instances, you can configure health checks. Health checks are important to ensure that NGINX doesn’t send traffic to a failing or unresponsive container.

You can use the proxy_next_upstream directive in NGINX to automatically skip over any unhealthy front-end instances.
Health Check Directives:

    interval=5s: Defines the interval (5 seconds) between each health check.

    fails=3: Specifies the number of failed health checks before a server is considered down.

    passes=2: Specifies the number of successful health checks required before a server is considered back up.

This configuration ensures that:

    If a front-end instance fails three consecutive health checks, NGINX will stop routing traffic to it.

    If a front-end instance passes two consecutive health checks after being considered unhealthy, it will start receiving traffic again.

    4. Testing and Monitoring Health Check Behavior

    Simulate Failure:
    To test how NGINX handles an unhealthy instance, you can manually stop one of the front-end containers:

sudo docker stop frontend2

Check Load Balancing Behavior:
Refresh the application in your browser and you should see that the requests are routed to frontend1 and frontend3 (since frontend2 is down).

Restart the Failed Instance:
To simulate the recovery of a failed instance, you can start it back again:

    sudo docker start frontend2

    Observe Health Checks:
    Once frontend2 starts, NGINX will begin routing traffic to it again after it successfully passes health checks.

Conclusion

The load balancer setup with NGINX ensures high availability and robustness for your application by:

    Using round-robin load balancing to evenly distribute traffic among your front-end instances.

    Implementing health checks to skip over unhealthy containers and ensure that only responsive front-end instances handle user traffic.

    Allowing you to easily scale your application with more instances of the front-end if needed, while maintaining seamless traffic distribution and failure recovery.

    Troubleshooting Tips for Common Issues
    Simplified Guide to Deploying the Environment on AWS EC2
1. Set Up EC2 Instance

    Launch EC2 Instance: Use Ubuntu 20.04 LTS (or preferred version), t2.micro (free tier).

    Configure Security: Open ports 80 (HTTP) and 22 (SSH) for remote access.

    Connect to EC2: SSH into your EC2 instance using your key pair:
    ssh -i /path/to/your-key.pem ubuntu@<your-ec2-public-ip>

2. Install Docker and Docker Compose

    Install Dependencies:

sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

Install Docker:

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install -y docker-ce

Install Docker Compose:

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

Verify Installation:

    docker --version
    docker-compose --version

3. Clone the Project Repository

    Install Git (if not installed):
    sudo apt install -y git

    Clone Your Project:

    git clone https://github.com/<your-username>/cs421-assignment.git
    cd cs421-assignment

4. Configure and Deploy Application

    Update docker-compose.yml: Ensure services (React front-end, Flask API, MySQL, NGINX) are correctly set up.

    Build and Start Containers:

    sudo docker-compose up -d --build

    Check Containers:
    sudo docker ps

5. Access the Application

    Security Group Setup: Ensure port 80 is open in your EC2 security group.

    Access the Application: Open a browser and go to http://<your-ec2-public-ip>.

6. Test Load Balancing

    Simulate Failure: Stop one front-end container:
    sudo docker stop frontend2

    Ensure Load Balancing: Refresh the browser, ensuring NGINX loads the remaining healthy containers.

    Recover Container: Start the stopped container:
    sudo docker start frontend2

7. Monitoring and Logging

    View Logs:

    sudo docker-compose logs frontend1
    sudo docker-compose logs api
    sudo docker-compose logs nginx-loadbalancer

8. Clean Up (Optional)

    Stop and Remove Containers:

    sudo docker-compose down --volumes --remove-orphans

Conclusion

You’ve successfully deployed a high-availability, Dockerized web app (React, Flask, MySQL) on AWS EC2. The NGINX load balancer ensures the app is responsive, even if a front-end container fails.
1. Front-End Not Loading

    Check if Containers Are Running: Use sudo docker ps to verify front-end containers are active. If not, check logs with sudo docker logs <container_name>.

    Check Ports: Ensure front-end containers (3000, 3001, 3002) are correctly mapped.

    Check NGINX Config: Ensure NGINX is forwarding requests properly (upstream frontend_servers).

    Clear Cache: Clear browser cache or use incognito mode.

2. Load Balancer Not Working (NGINX Issues)

    Check NGINX Logs: Run sudo docker logs nginx-loadbalancer.

    Verify NGINX Config: Ensure round-robin load balancing and health checks are correctly configured in nginx.conf.

    Check Service Dependencies: Ensure front-end containers are running before NGINX starts by using depends_on in docker-compose.yml.

    Verify Ports: Ensure correct port mappings for NGINX and React containers.

3. Custom Header (X-Node-ID) Not Appearing

    Check React Code: Ensure the front-end app is sending the header correctly (e.g., X-Node-ID: 'frontend1').

    Check Requests in Browser: Inspect network requests in Developer Tools to confirm the header is sent.

    Check NGINX Config: Ensure NGINX is passing the header to the back-end with proxy_set_header X-Node-ID $host.

4. API Not Responding or Data Not Showing

    Check Flask API Logs: Use sudo docker logs cs421-assignment-api-1 to check for errors.

    Verify Flask API Port: Ensure Flask API is listening on port 5000 and accessible.

    Test API: Use curl http://localhost:5000/students to check if API endpoints are working.

5. Port Conflicts or Build Errors

    Fix Port Conflicts: Ensure no conflicting port mappings in docker-compose.yml.

    Clean Up Docker: Run sudo docker system prune -a --volumes -f to clean up unused resources.

    Rebuild Containers: Run sudo docker-compose down --volumes and sudo docker-compose up -d --build.

6. General Docker Issues

    Restart Docker Service: Use sudo systemctl restart docker if Docker isn't responding.

    Check System Resources: Verify sufficient resources on EC2 using free -h and df -h.

By following these tips, you can resolve common issues related to front-end loading, NGINX, API, and Docker.

