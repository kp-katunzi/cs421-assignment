
FROM python:3.10-slim

#  Set the working directory
WORKDIR /app

# Copy requirements.txt  and requirements  available
COPY requirements.txt .

# Install the dependencies 
RUN pip install --no-cache-dir -r requirements.txt

#  Copy the rest of the application code into the container
COPY . .

#  Expose port 5000 and Flask app
EXPOSE 5000

CMD ["python", "app.py"]
