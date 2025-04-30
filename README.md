# tg-global-message-platform-rabbitmq
Rabbitmq messaging platform for Global messaging 


### First-time users install pre-requisites
  - Clone and navigate to the ```helm/tg-global-messafing-platform-rabbitmq``` folder.
  - Open ```values.yaml```  update the Password, this will help to login into the management console.
  - Run ```chmod +x pre-requisites.sh```
  - Run ```./pre-requisites.sh```
  - After successfully installing all the pre-requisites install rabbit using ```./deploy.sh``` script in the ```helm/tg-global-messafing-platform-rabbitmq```
  - Access Rabbitmq Manger on port http://127.0.0.1:15672/

### Manual installation steps
## Pre-Requisites 🐳 Docker Installation & Minikube 

### Windows

1. **Install Docker Desktop**:
   - Download the installer from the [official Docker website](https://www.docker.com/products/docker-desktop).
   - Run the installer and follow the on-screen instructions.
   - **Note**: Docker Desktop requires **Windows 10 Pro or Enterprise** with **Hyper-V** enabled. For Windows Home, Docker Desktop uses **WSL 2** (Windows Subsystem for Linux 2).

2. **Start Docker**:
   - After installation, launch Docker Desktop from the Start menu.
   - Docker will initialize and the whale icon will appear in the system tray when it's ready.

3. **Stop Docker**:
   - Right-click the Docker icon in the system tray and select **Quit Docker Desktop**.

### macOS

1. **Install Docker Desktop**:
   - Download the installer from the [official Docker website](https://www.docker.com/products/docker-desktop).
   - Open the `.dmg` file and drag the Docker icon to the Applications folder.
   - Launch Docker from the Applications folder.

2. **Start Docker**:
   - Upon first launch, Docker may prompt you to install its components. Follow the prompts to complete the setup.

3. **Stop Docker**:
   - Click the Docker icon in the menu bar and select **Quit Docker Desktop**.

---

## 🧱 Minikube Installation & Management

### Windows

1. **Install Minikube**:
   - Open PowerShell as Administrator and run:
     ```powershell
     choco install minikube
     ```
     *Note*: This requires [Chocolatey](https://chocolatey.org/) to be installed.

2. **Start Minikube**:
   - In PowerShell, run:
     ```powershell
     minikube start
     ```

3. **Stop Minikube**:
   - To stop the Minikube cluster, run:
     ```powershell
     minikube stop
     ```

### macOS

1. **Install Minikube**:
   - Using Homebrew:
     ```bash
     brew install minikube
     ```

2. **Start Minikube**:
   - In the terminal, run:
     ```bash
     minikube start
     ```

3. **Stop Minikube**:
   - To stop the Minikube cluster, run:
     ```bash
     minikube stop
     ```

---

## 🧪 Verify Installations

After installation, verify that both Docker and Minikube are running correctly:

- **For Docker**:
  ```bash
  docker --version
  docker run hello-world
  ```

- **For Minikube**:
  ```bash
  minikube status
  kubectl get nodes
  ```

### To Install rabbit in your local
  - Clone and navigate to the ```helm/tg-global-messaging-platform-rabbitmq``` folder.
  - Open ```value.yaml```  update the Passoword, this will help to login into the management console.
  - Run the shell script ```./cleanup-rabbitmq``` and then ```./deploy-rabbitmq.sh```
  - Check if the pods are running using ```kubectl get pods```, once you confirm pods are running 
  - Now run ```kubectl port-forward --namespace default svc/rabbitmq 15672:15672```
  - Access Rabbitmq Manger on port http://127.0.0.1:15672/


---