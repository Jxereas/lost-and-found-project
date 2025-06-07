# Lost and Found Project

This is a full-stack web application for managing lost and found items.  
It is built with **React (Vite)** for the frontend, **Django** for the backend, and **MySQL** for the database.

---

## Technologies Used

- React + Vite (Frontend)
- Django (Backend)
- MySQL (Database)
- Virtualenv (Python Environment)
- NPM (Node.js Package Manager)

---

## System Requirements

Before starting, ensure you have the following installed:

- Python 3.10 or higher
- Node.js and NPM (v16+ recommended)
- MySQL Server

---

## Project Setup Instructions

### Backend Setup (Django + MySQL)

1. Navigate to the backend folder and create virtual Python environment:

    Linux:
   ```bash
   cd backend
   python3 -m venv .venv
   source .venv/bin/activate
   ```

   Windows:
   ```bash
   cd backend
   python3 -m venv .venv
   source .venv/Scripts/activate
   ```

2. Install Python dependencies:

   ```bash
   pip install -r requirements.txt
   ```

3. Create a .env file in the backend/ directory with the following contents and modify your username and password:

   ```ini
   MYSQL_NAME=LostAndFoundProjectTest
   MYSQL_USER=your_mysql_username
   MYSQL_PASSWORD=your_mysql_password
   MYSQL_HOST=localhost
   MYSQL_PORT=3306
   ```

4. Add the .env to your .gitignore so that no one sees your password or username when you push to the repository.
5. Import the existing database if desired to your MySQL server:

   ```bash
   mysql -u your_mysql_username -p < lost-and-found.sql
   ```

6. Run the django server and make sure everything is working:

   ```bash
   python manage.py runserver
   ```

### Frontend Setup (React + Vite)

1. Navigate to the frontend:

   ```bash
   cd frontend
   ```

2. Install frontend dependencies:

   ```bash
   npm install
   ```

3. Run the development server and make sure everything is working:

   ```bash
   npm run dev
   ```

---

## Running the Full Application

Open two terminal windows or tabs:

1. In the first one, start the backend server:

   ```bash
   cd backend
   source .venv/bin/activate
   python manage.py runserver
   ```

2. In the second one, start the frontend:

   ```bash
   cd frontend
   npm run dev
   ```

3. Visit http://localhost:5173 to use the application.

---

## Gitignore Template (optional)

Here are the recommended entries to include in your `.gitignore` file for this project:

    # Virtual environment (Python package installations)
    .venv/
    venv/
    env/

    #Python cache files
    __pycache__/
    *.py[cod]
    *.pyo

    # Django secret / env file
    .env

    # Node dependencies
    node_modules/

    # Vite build output
    dist/

    # VSCode
    .vscode/

    # JetBrains / PyCharm
    .idea/

    # Coverage reports
    coverage/
    *.log
    *.tmp
