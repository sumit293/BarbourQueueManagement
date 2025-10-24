<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dbcon.ConnectDB"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Barbers - Admin Dashboard</title>
    <style>
        /* Modern Professional CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --secondary: #64748b;
            --dark: #1e293b;
            --light: #f8fafc;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --sidebar-width: 260px;
        }

        body {
            background: #f1f5f9;
            color: #334155;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--dark);
            color: white;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .logo-container {
            padding: 24px 20px;
            border-bottom: 1px solid #334155;
            text-align: center;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: white;
            margin-bottom: 4px;
        }

        .logo-subtitle {
            font-size: 12px;
            color: #94a3b8;
        }

        .nav-menu {
            padding: 20px 0;
        }

        .nav-section {
            margin-bottom: 24px;
        }

        .nav-title {
            font-size: 12px;
            color: #94a3b8;
            padding: 0 20px 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .nav-links {
            list-style: none;
        }

        .nav-links li {
            margin: 4px 0;
        }

        .nav-links a {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: #cbd5e1;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }

        .nav-links a:hover {
            background: #334155;
            color: white;
            border-left-color: var(--primary);
        }

        .nav-links a.active {
            background: #334155;
            color: white;
            border-left-color: var(--primary);
        }

        .nav-icon {
            width: 20px;
            height: 20px;
            margin-right: 12px;
            filter: invert(85%) sepia(10%) saturate(250%) hue-rotate(180deg) brightness(95%) contrast(85%);
        }

        .nav-links a:hover .nav-icon,
        .nav-links a.active .nav-icon {
            filter: invert(100%) sepia(0%) saturate(0%) hue-rotate(93deg) brightness(103%) contrast(103%);
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header Styles */
        .header {
            background: white;
            padding: 0 32px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            z-index: 100;
        }

        .header-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 0;
        }

        .header-title h1 {
            font-size: 24px;
            font-weight: 600;
            color: var(--dark);
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 8px 16px;
            background: var(--light);
            border-radius: 8px;
            cursor: pointer;
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            background: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }

        /* Dashboard Content */
        .dashboard-content {
            flex: 1;
            padding: 32px;
        }

        .page-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 24px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            color: var(--dark);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            padding: 10px 16px;
            background: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }

        .back-icon {
            width: 16px;
            height: 16px;
            margin-right: 8px;
            filter: invert(100%);
        }

        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 32px;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th {
            background: var(--light);
            padding: 16px 12px;
            text-align: left;
            font-weight: 600;
            color: var(--dark);
            border-bottom: 1px solid #e2e8f0;
        }

        .data-table td {
            padding: 14px 12px;
            border-bottom: 1px solid #f1f5f9;
        }

        .data-table tr:hover {
            background: #f8fafc;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-approved {
            background: #d1fae5;
            color: #065f46;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-rejected {
            background: #fee2e2;
            color: #991b1b;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 8px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-approve {
            background: var(--success);
            color: white;
        }

        .btn-approve:hover {
            background: #059669;
            transform: translateY(-1px);
        }

        .btn-delete {
            background: var(--danger);
            color: white;
        }

        .btn-delete:hover {
            background: #dc2626;
            transform: translateY(-1px);
        }

        .btn-icon {
            width: 14px;
            height: 14px;
            margin-right: 6px;
            filter: invert(100%);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--secondary);
        }

        .empty-icon {
            width: 80px;
            height: 80px;
            margin-bottom: 16px;
            opacity: 0.5;
        }

        /* Footer Styles */
        .footer {
            background: var(--dark);
            color: white;
            padding: 24px 32px;
            margin-top: auto;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 32px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .footer-section h4 {
            font-size: 16px;
            margin-bottom: 16px;
            color: white;
        }

        .footer-section p, .footer-section a {
            color: #94a3b8;
            font-size: 14px;
            text-decoration: none;
            line-height: 1.6;
        }

        .footer-section a:hover {
            color: white;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 24px;
            margin-top: 24px;
            border-top: 1px solid #334155;
            color: #94a3b8;
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .main-content {
                margin-left: 0;
            }

            .table-container {
                overflow-x: auto;
            }

            .data-table {
                min-width: 800px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <nav class="sidebar">
        <div class="logo-container">
            <div class="logo">BARBERQUEUE</div>
            <div class="logo-subtitle">ADMIN DASHBOARD</div>
        </div>

        <div class="nav-menu">
            <div class="nav-section">
                <div class="nav-title">Main Navigation</div>
                <ul class="nav-links">
                    <li><a href="adminzdashboard.html">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHJlY3Qgd2lkdGg9IjE4IiBoZWlnaHQ9IjE4IiB4PSIzIiB5PSIzIiByeD0iMiIgcnk9IjIiPjwvcmVjdD48cGF0aCBkPSJNMyA5aDE4TTkgMjFWOUIiPjwvcGF0aD48L3N2Zz4=" class="nav-icon" alt="Dashboard">
                        Dashboard
                    </a></li>
                    <li><a href="#" class="active">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTIwIDIxdi0yYTQgNCAwIDAgMC00LTRINGE0IDQgMCAwIDAtNCA0djIiPjwvcGF0aD48Y2lyY2xlIGN4PSIxMiIgY3k9IjciIHI9IjQiPjwvY2lyY2xlPjwvc3ZnPg==" class="nav-icon" alt="Barbers">
                        Manage Barbers
                    </a></li>
                    <li><a href="manageCustomer.jsp">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTE3IDIxdi0yYTQgNCAwIDAgMC00LTRINS00YTQgNCAwIDAgMC00IDR2MiI+PC9wYXRoPjxjaXJjbGUgY3g9IjkiIGN5PSI3IiByPSI0Ij48L2NpcmNsZT48cGF0aCBkPSJNMjMgMjF2LTJhNCA0IDAgMCAwLTMtMy44NyI+PC9wYXRoPjxwYXRoIGQ9Ik0xNiAzLjEzYTQgNCAwIDAgMSAwIDcuNzUiPjwvcGF0aD48L3N2Zz4=" class="nav-icon" alt="Customers">
                        Manage Customers
                    </a></li>
                </ul>
            </div>

            <div class="nav-section">
                <div class="nav-title">System Access</div>
                <ul class="nav-links">
                    <li><a href="adminlogin.html">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTE1IDNINDhjMS4xIDAgMiAuOSAyIDJ2MTRjMCAxLjEtLjkgMi0yIDJINGMtMS4xIDAtMi0uOS0yLTJWNWMwLTEuMS45LTIgMi0yeiI+PC9wYXRoPjxwb2x5bGluZSBwb2ludHM9IjEwLDE3IDE1LDEyIDEwLDciPjwvcG9seWxpbmU+PC9zdmc+" class="nav-icon" alt="Admin">
                        Admin Login
                    </a></li>
                    <li><a href="barberLogin.html">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHJlY3QgeD0iMyIgeT0iMyIgd2lkdGg9IjE4IiBoZWlnaHQ9IjE4IiByeD0iMiIgcnk9IjIiPjwvcmVjdD48Y2lyY2xlIGN4PSI4LjUiIGN5PSI4LjUiIHI9IjEuNSI+PC9jaXJjbGU+PHBvbHlsaW5lIHBvaW50cz0iMjEuMTUsMTUuMzkgMTYsMTMgOCwxMyAzLjE1LDE1LjM5Ij48L3BvbHlsaW5lPjxsaW5lIHgxPSI5IiB5MT0iMTkiIHgyPSIxNSIgeTI9IjE5Ij48L2xpbmU+PC9zdmc+" class="nav-icon" alt="Barber">
                        Barber Login
                    </a></li>
                    <li><a href="customerLogin.html">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTE2IDIxdi0yYTQgNCAwIDAgMC00LTRINGE0IDQgMCAwIDAtNCA0djIiPjwvcGF0aD48Y2lyY2xlIGN4PSI5IiBjeT0iNyIgcj0iNCI+PC9jaXJjbGU+PHBhdGggZD0iTTIyIDIxdi0yYTQgNCAwIDAgMC0zLTMuODciPjwvcGF0aD48cGF0aCBkPSJNMTYgMy4xM2E0IDQgMCAwIDEgMCA3Ljc1Ij48L3BhdGg+PC9zdmc+" class="nav-icon" alt="Customer">
                        Customer Login
                    </a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <header class="header">
            <div class="header-content">
                <div class="header-title">
                    <h1>Barber Management</h1>
                </div>
                <div class="header-actions">
                    <div class="user-profile">
                        <div class="user-avatar">A</div>
                        <span>Administrator</span>
                    </div>
                </div>
            </div>
        </header>

        <!-- Dashboard Content -->
        <main class="dashboard-content">
            <div class="page-header">
                <h2 class="page-title">Manage Barbers</h2>
                <a href="admindashboard.html" class="back-link">
                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTE5IDEySDVNMTIgMTlsLTctNyA3LTciPjwvcGF0aD48L3N2Zz4=" class="back-icon" alt="Back">
                    Back to Dashboard
                </a>
            </div>

            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Barber Name</th>
                            <th>Email</th>
                            <th>Contact</th>
                            <th>Shop</th>
                            <th>Status</th>
                            <th>Change Status</th>
                            <th>Delete Barber</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        try {
                            Connection con = ConnectDB.getConnect();
                            String sql = "select * from barber";
                            PreparedStatement ps1 = con.prepareStatement(sql);
                            ResultSet rs = ps1.executeQuery();
                            
                            boolean hasData = false;
                            
                            while(rs.next()) {
                                hasData = true;
                                String status = rs.getString(7);
                                String statusClass = "status-pending";
                                
                                if ("approved".equalsIgnoreCase(status)) {
                                    statusClass = "status-approved";
                                } else if ("rejected".equalsIgnoreCase(status)) {
                                    statusClass = "status-rejected";
                                }
                        %>
                        <tr>
                            <td><%=rs.getString(2) %></td>
                            <td><%=rs.getString(3) %></td>
                            <td><%=rs.getString(4) %></td>
                            <td><%=rs.getString(6) %></td>
                            <td><span class="status-badge <%=statusClass%>"><%=rs.getString(7) %></span></td>
                            <td>
                                <div class="action-buttons">
                                    <a href="barberApprove.jsp?bid=<%= rs.getInt("bid") %>" class="btn btn-approve">
                                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTIwIDZMOSAxN2wtNS01Ij48L3BhdGg+PC9zdmc+" class="btn-icon" alt="Approve">
                                        Approve
                                    </a>
                                </div>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="barberDelete.jsp?bid=<%= rs.getInt("bid") %>" class="btn btn-delete" onclick="return confirmDelete()">
                                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTMgNmgyMk0xOSA2djE0YTIgMiAwIDAgMS0yIDJIN2EyIDIgMCAwIDEtMi0yVjZtMyAwVjRhMiAyIDAgMCAxIDItMmg0YTIgMiAwIDAgMSAyIDJ2MiI+PC9wYXRoPjwvc3ZnPg==" class="btn-icon" alt="Delete">
                                        Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                            
                            if (!hasData) {
                        %>
                        <tr>
                            <td colspan="7">
                                <div class="empty-state">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjOTRBM0I4IiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTIwIDIxdi0yYTQgNCAwIDAgMC00LTRINGE0IDQgMCAwIDAtNCA0djIiPjwvcGF0aD48Y2lyY2xlIGN4PSIxMiIgY3k9IjciIHI9IjQiPjwvY2lyY2xlPjwvc3ZnPg=" class="empty-icon" alt="No Barbers">
                                    <h3>No Barbers Found</h3>
                                    <p>There are currently no barbers registered in the system.</p>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        } catch(Exception e) {
                            e.printStackTrace();
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </main>

        <!-- Footer -->
        <footer class="footer">
            <div class="footer-content">
                <div class="footer-section">
                    <h4>Contact Information</h4>
                    <p>Email: admin@barberqueue.com</p>
                    <p>Phone: +1 (555) 123-4567</p>
                    <p>Support: support@barberqueue.com</p>
                </div>
                
                <div class="footer-section">
                    <h4>Quick Links</h4>
                    <p><a href="adminlogin.html">Admin Login</a></p>
                    <p><a href="barberLogin.html">Barber Login</a></p>
                    <p><a href="customerLogin.html">Customer Login</a></p>
                    <p><a href="index.html">Home Page</a></p>
                </div>
                
                <div class="footer-section">
                    <h4>System Information</h4>
                    <p>Barber Queue Management System</p>
                    <p>Version 2.1.0</p>
                    <p>Last Updated: 2024</p>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2024 Barber Queue Management System. All rights reserved. | Privacy Policy | Terms of Service</p>
            </div>
        </footer>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add active state to navigation links
            const navLinks = document.querySelectorAll('.nav-links a');
            navLinks.forEach(link => {
                link.addEventListener('click', function() {
                    navLinks.forEach(l => l.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // User profile interaction
            const userProfile = document.querySelector('.user-profile');
            userProfile.addEventListener('click', function() {
                alert('Admin profile menu would open here');
            });

            // Add loading animation to action buttons
            const actionButtons = document.querySelectorAll('.btn');
            actionButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    if (!this.classList.contains('btn-delete') || confirmDelete()) {
                        const originalHTML = this.innerHTML;
                        this.innerHTML = '<img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PGNpcmNsZSBjeD0iMTIiIGN5PSIxMiIgcj0iMTAiPjwvY2lyY2xlPjxwb2x5bGluZSBwb2ludHM9IjEyIDYgMTIgMTIgMTYuNSAxNCI+PC9wb2x5bGluZT48L3N2Zz4=" class="btn-icon" alt="Loading">Processing...';
                        this.style.opacity = '0.8';
                        this.style.pointerEvents = 'none';
                        
                        setTimeout(() => {
                            this.innerHTML = originalHTML;
                            this.style.opacity = '1';
                            this.style.pointerEvents = 'auto';
                        }, 1500);
                    } else {
                        e.preventDefault();
                    }
                });
            });
        });

        function confirmDelete() {
            return confirm('Are you sure you want to delete this barber? This action cannot be undone.');
        }
    </script>
</body>
</html>