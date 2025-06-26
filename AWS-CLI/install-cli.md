Here's a simple,  **"Installing AWS CLI and Checking If Signed In"** – suitable for teams, personal notes, or Notion-style documentation. Includes steps for **Windows, macOS, and Linux**.

---

## 🚀 How to Install AWS CLI and Check If You're Signed In

### ✅ Prerequisites

* Admin access to your system
* Internet connection

---

### 🧰 Step 1: Install AWS CLI

#### 🪟 **For Windows**

```powershell
# 1. Download the installer
Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -OutFile "AWSCLIV2.msi"

# 2. Run installer
Start-Process .\AWSCLIV2.msi
```

Or manually download: [https://awscli.amazonaws.com/AWSCLIV2.msi](https://awscli.amazonaws.com/AWSCLIV2.msi)

---

#### 🍎 **For macOS**

```bash
# 1. Download installer
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"

# 2. Install
sudo installer -pkg AWSCLIV2.pkg -target /
```

---

#### 🐧 **For Linux**

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

---

### 🧪 Step 2: Verify Installation

```bash
aws --version
```

✅ Expected output:

```
aws-cli/2.x.x Python/3.x.x ... 
```

---

### 🔐 Step 3: Configure AWS Credentials

```bash
aws configure
```

It will ask:

```
AWS Access Key ID [None]: <Your Access Key>
AWS Secret Access Key [None]: <Your Secret Key>
Default region name [None]: ap-south-1
Default output format [None]: json
```

---

### 🔍 Step 4: Check If Signed In

To verify credentials:

```bash
aws sts get-caller-identity
```

✅ Output:

```json
{
  "UserId": "AIDAEXAMPLE",
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/your-user"
}
```

If credentials are invalid, you'll get an error like:

```bash
An error occurred (UnrecognizedClientException) when calling the GetCallerIdentity operation: The security token included in the request is invalid.
```

---

