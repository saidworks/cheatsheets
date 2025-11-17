# Open WebUI Installation & Management

---

## 🚀 Installation Steps

### 1. Create a Virtual Environment
```bash
python3 -m venv venv
```

### 2. Activate the Virtual Environment

**On Linux/macOS:**
```bash
source venv/bin/activate
```

**On Windows:**
```cmd
venv\Scripts\activate
```

### 3. Install Open WebUI
```bash
pip install open-webui
```

### 4. Start the Server
```bash
open-webui serve
```

---

## 🔄 Updating Open WebUI

To update your locally installed Open WebUI package to the latest version:

```bash
pip install -U open-webui
```

> 💡 **Note:** The `-U` (or `--upgrade`) flag ensures that pip upgrades the package to the latest available version.

That's it! Your Open WebUI package is now updated and ready to use.

---

## 🐳 Docker Installation

### 1. Install Docker

Ensure Docker is installed on your system. Visit [Docker's official website](https://www.docker.com/get-started) for installation instructions.

### 2. Run Open WebUI with Docker

```bash
docker run -d \
  --name open-webui \
  -p 8080:8080 \
  -v open-webui-data:/app/backend/data \
  ghcr.io/open-webui/open-webui:latest
```

> 💡 **Note:** The container exposes port 8080. You can access Open WebUI at http://localhost:8080

### 3. Using NVIDIA GPU Support

To run Open WebUI with NVIDIA GPU support, you need:

1. NVIDIA drivers installed on your host
2. NVIDIA Container Toolkit installed

```bash
# Install NVIDIA Container Toolkit (Ubuntu example)
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

Then run Open WebUI with GPU support:

```bash
docker run -d \
  --name open-webui-gpu \
  --gpus all \
  -p 8080:8080 \
  -v open-webui-data:/app/backend/data \
  ghcr.io/open-webui/open-webui:latest
```

### 4. Updating Docker Container

To update to the latest version of Open WebUI Docker image:

```bash
# Stop and remove the current container
docker stop open-webui
docker rm open-webui

# Pull the latest image
docker pull ghcr.io/open-webui/open-webui:latest

# Run a new container with the updated image
docker run -d \
  --name open-webui \
  -p 8080:8080 \
  -v open-webui-data:/app/backend/data \
  ghcr.io/open-webui/open-webui:latest
```

For GPU version, replace the container name and add `--gpus all` flag.