Here’s a **complete step-by-step guide** to:

✅ Install **Minikube** on your Jenkins server
✅ Allow Jenkins user to access it via `kubectl`

---

## 🧱 System Requirements (Ubuntu/Debian)

* OS: Ubuntu 20.04 / 22.04
* Jenkins user: default (`jenkins`)
* Docker installed and working (used as Minikube driver)

---

## ✅ Step 1: Install Dependencies

```bash
sudo apt update
sudo apt install -y curl wget apt-transport-https ca-certificates gnupg
```

---

## ✅ Step 2: Install Docker (if not already)

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

Then add Jenkins user to Docker group:

```bash
sudo usermod -aG docker jenkins
newgrp docker
```

✅ Restart Jenkins:

```bash
sudo systemctl restart jenkins
```

---

## ✅ Step 3: Install `kubectl`

```bash
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

Verify:

```bash
kubectl version --client
```

---

## ✅ Step 4: Install Minikube

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

---

## ✅ Step 5: Start Minikube as Jenkins User

Switch to the `jenkins` user:

```bash
sudo su - jenkins
```

Now start Minikube using Docker as the driver:

```bash
minikube start --driver=docker
```

This will:

* Start a local K8s cluster in Docker
* Automatically create `~/.kube/config` for Jenkins

---

## ✅ Step 6: Test Access as Jenkins

Still as the `jenkins` user:

```bash
kubectl get nodes
minikube status
```

✅ You should see a node like `minikube Ready`.

---

## ✅ Step 7: Use in Jenkins Pipeline

Now your Jenkinsfile can include:

```groovy
stage('Deploy to K8s') {
  steps {
    sh 'kubectl get nodes'
  }
}
```


