# Use the official Python image
FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Install PostgreSQL development packages and other dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    pip list

# Copy the rest of the application code
COPY . .

# Command to run the application using gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "djangoProject.wsgi:application"]