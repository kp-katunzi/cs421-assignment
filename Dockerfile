# Step 1: Use the official Python image as a base
FROM python:3.10-slim

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy requirements.txt and install dependencies
COPY requirements.txt .

# Install the dependencies listed in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Step 4: Copy the rest of the application code into the container
COPY . .

# Step 5: Expose port 5000 (Flask default port)
EXPOSE 5000

# Step 6: Set the environment variable for Flask
ENV FLASK_APP=app.py
ENV FLASK_ENV=development

# Step 7: Run the Flask application
CMD ["flask", "run", "--host=0.0.0.0"]
