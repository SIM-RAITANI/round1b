# Docker Setup for modelpdf

This Docker setup allows you to run the `main4.py` script in a containerized environment.

## Prerequisites

- Docker installed on your system
- Docker Compose installed (usually comes with Docker Desktop)

## Files Structure

The Docker setup expects the following structure:
```
modelpdf/
├── Dockerfile
├── docker-compose.yml
├── main4.py
├── requirements.txt
├── lgbm_classifier.joblib
├── label_map.json
├── lgbm_features.json
├── my_finetuned_minilm_model/
├── input/                  # Place your input files here
└── output/                 # Results will appear here
```

## How to Use

### 1. Prepare Input Files

Place your input files in the `input/` directory:
- PDF files to be processed
- `challenge1b_input.json` (the main input configuration file)

### 2. Build and Run with Docker Compose

```bash
# Build and run the container
docker-compose up --build

# Or run in detached mode
docker-compose up -d --build
```

### 3. Alternative: Build and Run with Docker directly

```bash
# Build the image
docker build -t modelpdf-app .

# Run the container with volume mounts
docker run -v "%cd%\input:/app/input" -v "%cd%\output:/app/output" modelpdf-app
```

### 4. Check Results

After the container finishes running, check the `output/` directory for the results.

## Environment Variables

The container sets the following environment variables:
- `PYTHONUNBUFFERED=1` - Ensures Python output is not buffered

## Volumes

- `./input:/app/input` - Maps your local input directory to the container
- `./output:/app/output` - Maps your local output directory to the container

## Troubleshooting

1. **Permission Issues**: On Linux/Mac, you might need to fix permissions:
   ```bash
   sudo chown -R $USER:$USER output/
   ```

2. **Build Issues**: Clear Docker cache and rebuild:
   ```bash
   docker-compose down
   docker system prune -f
   docker-compose up --build
   ```

3. **View Logs**: To see what's happening inside the container:
   ```bash
   docker-compose logs -f
   ```

## Interactive Mode

To run the container interactively (useful for debugging):

```bash
docker-compose run --rm modelpdf bash
```

This will give you a shell inside the container where you can manually run `python main4.py` or debug issues.
