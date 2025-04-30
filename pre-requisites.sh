#!/usr/bin/env bash
set -euo pipefail

# Function to check if Docker is ready
function wait_for_docker() {
  echo -n "Waiting for Docker to be ready"
  until docker info &>/dev/null; do
    echo -n "."
    sleep 2
  done
  echo " ready!"
}

case "$(uname -s)" in
  Darwin)
    echo "Detected macOS"

    # 1) Install Homebrew if missing
    if ! command -v brew &>/dev/null; then
      echo "Installing Homebrew…"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # 2) Install Docker Desktop if missing
    if ! command -v docker &>/dev/null; then
      echo "Installing Docker Desktop via Homebrew Cask…"
      brew install --cask docker
    fi

    # 3) Launch Docker Desktop if not running
    if ! pgrep -xq "Docker"; then
      echo "Starting Docker Desktop…"
      open -a Docker
      # Wait for Docker to be ready
      wait_for_docker
    else
      echo "Docker is already running."
    fi


    # 4) Install minikube if not installed
    if ! command -v minikube &>/dev/null; then
      echo "Installing minikube"
      brew install minikube
    fi

    # 5) Start minikube 
    echo "Starting Minikube"
    minikube start

    ;;

  MINGW*|MSYS*|CYGWIN*)
    echo "Detected Windows (Git Bash/MSYS/Cygwin)"

    # 1) Install Chocolatey if missing
    if ! command -v choco &>/dev/null; then
      echo "Installing Chocolatey…"
      powershell -NoProfile -ExecutionPolicy Bypass -Command \
        "Set-ExecutionPolicy Bypass -Scope Process -Force;
         [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
         iex ((New-Object Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    fi

    # 2) Install Docker Desktop if missing
    if ! command -v docker &>/dev/null; then
      echo "Installing Docker Desktop via Chocolatey…"
      choco install docker-desktop -y
    fi

    # 3) Launch Docker Desktop if not running
    if ! pgrep -xq "Docker"; then
      echo "Starting Docker Desktop…"
      powershell -NoProfile -ExecutionPolicy Bypass -Command \
        "Start-Process -FilePath 'C:\\Program Files\\Docker\\Docker\\Docker Desktop.exe' -WindowStyle Hidden"
      # Wait for Docker to be ready
      wait_for_docker
    else
      echo "Docker is already running."
    fi

    # 4) Install minikube if not installed
    if ! command -v minikube &>/dev/null; then
      echo "Installing minikube"
      choco install minikube
    fi

    # 5) Start minikube 
    echo "Starting Minikube"
    powershell minikube start

    # 6) Installing Rabbit using bitnami helm 
    if ! command -v wsl &>/dev/null; then
      echo "Installing WSL…"
      wsl --install
    fi
    ;;

  *)
    echo "Unsupported OS: $(uname -s)"
    exit 1
    ;;
esac