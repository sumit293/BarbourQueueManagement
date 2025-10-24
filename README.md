# Smart Barber Queue Management System ✂️🚀

A web-based system designed to simplify salon queue management by enabling customers to book appointments online, barbers to manage their queues efficiently, and admins to control the business operations digitally.

---

## 💡 Project Overview

Barber shops often face long waiting lines, manual records, and miscommunication.  
This system solves that by bringing:

✅ Online appointment booking  
✅ Queue/slot management  
✅ Customer & Barber dashboards  
✅ Admin control over barbers, services, customers, and appointments  

A complete digital queue solution for modern barbershops 😎

---

## 👥 User Roles & Features

### 🧑‍💼 Admin
- Admin Login Dashboard
- Add/Delete Barbers
- Add/Delete Customers
- Manage Services (price, name, update, delete)
- View/Delete Appointments

### 💈 Barber
- Login Dashboard
- Approve/Reject Appointments
- Manage Personal Queue

### 🧑 Customer
- Register & Login
- Book Appointment
- View Appointment Status
- Cancel Appointment

---

## 🛠️ Technologies Used

| Layer | Technology |
|------|------------|
| Frontend | HTML, CSS, JSP |
| Backend | Java (JSP + Servlets + JDBC) |
| Database | MySQL |
| Server | Apache Tomcat |
| Architecture | MVC with POJO classes |

---

## 🗄️ Database Details

**Database Name:** `barbourdb`

| Table Name | Purpose |
|-----------|---------|
| `barber` | Stores barber profiles |
| `customer` | Stores customer details |
| `services` | Available services & prices |
| `appointment` | Booking records |

📌 DB connection handled via `WEB-INF/classes/dbcon/ConnectDB.java`

> You must update your MySQL username/password in `ConnectDB.java` before running.

---

## 🏗️ Project Structure




---

## 🚀 How to Run This Project

1️⃣ Import database  
- Create DB: `barbourdb`
- Import SQL tables (admin will provide or generate from code)

2️⃣ Deploy WAR on Tomcat  
- Copy `BarbourQueueManagement.war` to:

- Start Tomcat
- Access app in browser:


---

## 📌 Future Enhancements
- Automatic time-slot scheduling
- Notifications (SMS/Email)
- Payment Integration
- Modern UI with Angular/React

---

## 👤 Author
**Sumit**  
Developer — Smart Barber Queue Automation ✂️

If you like this project, ⭐ star the repo and share suggestions 😄

---
