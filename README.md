# 🌐 Desafio Técnico - DevOps 🚀

This project focuses on Terraform, Docker, Networking, and Deployment concepts. The goal is to manage containers, interact with a PostgreSQL database, and create a frontend that communicates with a backend API.

## 📖 Table of Contents
- [Introduction](#introduction)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Useful Commands](#useful-commands)
- [Project Structure](#project-structure)
- [Additional Notes](#additional-notes)

## 📝 Introduction
This project combines DevOps, Terraform, Docker, and PostgreSQL to create an application where the frontend interacts with a backend API, which connects to a PostgreSQL database. The backend serves data and handles database queries.

## ⚙️ Requirements
Before starting, ensure you have the following installed:

- **Terraform**: Install Terraform
- **Docker**: Install Docker
- **PostgreSQL**: A PostgreSQL instance (local or containerized) for the backend.
- A text editor (recommended: VSCode).

## 🛠️ Installation
### 1. Clone this repository
Start by cloning the project to your local machine:

```bash
git clone https://github.com/your-username/desafio-tecnico-devops.git
cd desafio-tecnico-devops
```
### 2. Install dependencies
Backend
No Node.js dependencies are required since we're using a simple HTTP server. Just ensure you have the pg (PostgreSQL client) installed.

```bash
cd backend
npm install pg
```

Frontend
The frontend is a static HTML file with no external dependencies, so no installations are required here.

## 🛠️ Configuration
### Environment Variables
For the backend, configure your PostgreSQL connection string inside the backend/index.js file (update these values accordingly):
```javascript
const client = new PG.Client({
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  host: process.env.DB_HOST || 'postgres',
  database: process.env.DB_NAME,
  port: process.env.DB_PORT || 5432
});
```
### Terraform
Ensure you have your infrastructure defined in the terraform folder. Initialize and apply Terraform to set up the containers:

Initialize Terraform:
```bash
terraform init
```

Apply Terraform to create the infrastructure:
```bash
terraform apply
```
This will provision the necessary infrastructure, including Docker containers, networks, and volumes.

### Backend
The backend is a simple Node.js server with PostgreSQL integration. To start the backend, run:
```bash
node backend/index.js
```
Ensure your PostgreSQL container or instance is running and accessible.

### Frontend
The frontend is a static HTML file with no dynamic content. Simply open the frontend/index.html file in your browser to interact with the app.

## 💻 Useful Commands
Restart Infrastructure: To restart your Docker containers and infrastructure, use:
```bash
terraform destroy
terraform apply
```

View Container Logs: To check the logs of a running container:
```bash
docker logs <container-name>
```

Connect to a Container: To connect to a running container:
```bash
docker exec -it <container-name> bash
```

## 📂 Project Structure
Here’s the project structure for your reference:

```bash
/desafio-tecnico-devops
├── backend
│   ├── index.js        # Backend logic (PostgreSQL connection)
│   ├── package.json    # Backend dependencies (e.g., pg)
├── frontend
│   └── index.html      # Frontend HTML file
├── terraform
│   ├── main.tf         # Terraform configuration for Docker containers
│   └── variables.tf    # Terraform variables
├── README.md           # Project README
```
backend: Contains the logic for the backend server and database connection.
frontend: Static frontend files (HTML only).
terraform: Defines your infrastructure setup for Docker containers and networks.

## 📝 Additional Notes
Make sure your PostgreSQL database is accessible and properly configured in the backend. If you're running it inside Docker, ensure the correct container name and port are being used.
If you modify Terraform files, remember to run terraform apply again to apply any infrastructure changes.
Frontend: The frontend is simple and contains only HTML, but it can be extended with JavaScript for more interactivity.

## 🎉 Final Thoughts
Now you’re ready to manage your infrastructure, deploy containers, and interact with your app! 🚀

Feel free to explore and modify the backend and frontend components to suit your needs!
