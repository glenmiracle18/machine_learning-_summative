# Use Python 3.9 slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /src

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY src /src
COPY models /models

# Make port available
ENV PORT 8000
EXPOSE ${PORT}

# Command to run the application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]