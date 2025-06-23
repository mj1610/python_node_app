FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy only requirements.txt first (so Docker caches pip install if it doesn't change)
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Now copy the rest of the code
COPY . .

# Run the app
CMD ["python", "app.py"]
