# Use Python 3.9 as base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Download NLTK data during build
RUN python -c "import nltk; nltk.download('punkt', quiet=True); nltk.download('punkt_tab', quiet=True)"

# Copy all necessary files
COPY main4.py .
COPY lgbm_classifier.joblib .
COPY label_map.json .
COPY lgbm_features.json .
COPY my_finetuned_minilm_model/ ./my_finetuned_minilm_model/

# Create input and output directories
RUN mkdir -p /app/input /app/output

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Expose port if needed (optional)
EXPOSE 8000

# Default command - run the main script
CMD ["python", "main4.py"]
