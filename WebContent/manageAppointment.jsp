<%@ page import="java.sql.*" %>
<%@ page import="dbcon.ConnectDB" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Appointments - Barber Dashboard</title>
    <style>
        /* Modern Professional CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: #f59e0b;
            --primary-dark: #d97706;
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
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            color: var(--dark);
        }

        .page-subtitle {
            color: var(--secondary);
            font-size: 16px;
            margin-top: 8px;
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

        .appointments-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 32px;
        }

        .appointments-table {
            width: 100%;
            border-collapse: collapse;
        }

        .appointments-table th {
            background: var(--light);
            padding: 16px 12px;
            text-align: left;
            font-weight: 600;
            color: var(--dark);
            border-bottom: 1px solid #e2e8f0;
        }

        .appointments-table td {
            padding: 16px 12px;
            border-bottom: 1px solid #f1f5f9;
        }

        .appointments-table tr:hover {
            background: #f8fafc;
        }

        .customer-name {
            font-weight: 600;
            color: var(--dark);
        }

        .service-name {
            font-weight: 500;
            color: var(--dark);
        }

        .service-description {
            color: var(--secondary);
            font-size: 14px;
            line-height: 1.5;
        }

        .service-price {
            font-weight: 700;
            color: var(--success);
            font-size: 16px;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-confirmed {
            background: #d1fae5;
            color: #065f46;
        }

        .status-completed {
            background: #e0e7ff;
            color: #3730a3;
        }

        .status-cancelled {
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
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
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

        .stats-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-left: 4px solid var(--primary);
        }

        .stat-card.pending {
            border-left-color: var(--warning);
        }

        .stat-card.confirmed {
            border-left-color: var(--success);
        }

        .stat-card.completed {
            border-left-color: #8b5cf6;
        }

        .stat-card.total {
            border-left-color: var(--primary);
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 8px;
        }

        .stat-label {
            color: var(--secondary);
            font-size: 14px;
            font-weight: 500;
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

        /* Mobile Menu Toggle */
        .mobile-menu-toggle {
            display: none;
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 16px;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.mobile-open {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .mobile-menu-toggle {
                display: block;
            }
        }

        @media (max-width: 768px) {
            .dashboard-content {
                padding: 20px 16px;
            }
            
            .header {
                padding: 0 16px;
            }
            
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }
            
            .stats-summary {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .appointments-container {
                overflow-x: auto;
            }
            
            .appointments-table {
                min-width: 800px;
            }
        }

        @media (max-width: 480px) {
            .header-content {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
            
            .header-actions {
                width: 100%;
                justify-content: space-between;
            }
            
            .stats-summary {
                grid-template-columns: 1fr;
            }
            
            .footer-content {
                grid-template-columns: 1fr;
                gap: 24px;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 4px;
            }
        }
    </style>
</head>
<body>
    <!-- Mobile Menu Toggle -->
    <button class="mobile-menu-toggle" id="mobileMenuToggle">
        ☰ Menu
    </button>

    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <div class="logo-container">
            <div class="logo">BARBERQUEUE</div>
            <div class="logo-subtitle">BARBER DASHBOARD</div>
        </div>

        <div class="nav-menu">
            <div class="nav-section">
                <div class="nav-title">Main Navigation</div>
                <ul class="nav-links">
                    <li><a href="barberdashboard.html">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHJlY3Qgd2lkdGg9IjE4IiBoZWlnaHQ9IjE4IiB4PSIzIiB5PSIzIiByeD0iMiIgcnk9IjIiPjwvcmVjdD48cGF0aCBkPSJNMyA5aDE4TTkgMjFWOUIiPjwvcGF0aD48L3N2Zz4=" class="nav-icon" alt="Dashboard">
                        Dashboard
                    </a></li>
                    <li><a href="#" class="active">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTkgNUg3YTIgMiAwIDAgMC0yIDJ2MTRhMiAyIDAgMCAwIDIgMmgxMGEyIDIgMCAwIDAgMi0yVjdhMiAyIDAgMCAwLTItMmgtMm0tOSA5aDZtLTYgNGg2bTgtNFY0bTAtNnY0Ij48L3BhdGg+PC9zdmc+" class="nav-icon" alt="Appointments">
                        Manage Appointments
                    </a></li>
                    <li><a href="ManageServices.jsp">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTIwIDIxdi0yYTQgNCAwIDAgMC00LTRINGE0IDQgMCAwIDAtNCA0djIiPjwvcGF0aD48Y2lyY2xlIGN4PSIxMiIgY3k9IjciIHI9IjQiPjwvY2lyY2xlPjwvc3ZnPg==" class="nav-icon" alt="Services">
                        Manage Services
                    </a></li>
                </ul>
            </div>

            <div class="nav-section">
                <div class="nav-title">Services</div>
                <ul class="nav-links">
                    <li><a href="addServices.html">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTEyIDV2MTQiPjwvcGF0aD48cGF0aCBkPSJNNSAxMmgxNCI+PC9wYXRoPjwvc3ZnPg==" class="nav-icon" alt="Add">
                        Add Services
                    </a></li>
                    <li><a href="#">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTEyIDE1djciPjwvcGF0aD48cGF0aCBkPSJNMTYuMDYgMTEuOTRhMyAzIDAgMSAwLTQuMTIgMEwxMiAxNS45OWwtLjU0LS41NGExIDEgMCAwIDAtMS4zMiAxLjMzbDMgM2ExIDEgMCAwIDAgMS40yAwbDMtM2ExIDEgMCAwIDAtMS40Mi0xLjQyeiI+PC9wYXRoPjwvc3ZnPg==" class="nav-icon" alt="History">
                        Service History
                    </a></li>
                </ul>
            </div>

            <div class="nav-section">
                <div class="nav-title">Account</div>
                <ul class="nav-links">
                    <li><a href="#">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTEyIDEyYTMgMyAwIDEgMCAwLTYgMyAzIDAgMCAwIDAgNnoiPjwvcGF0aD48cGF0aCBkPSJNMTkgMjF2LTJhNCA0IDAgMCAwLTQtNEg5YTQgNCAwIDAgMC00IDR2MiI+PC9wYXRoPjwvc3ZnPg==" class="nav-icon" alt="Profile">
                        My Profile
                    </a></li>
                    <li><a href="index.html">
                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTE5IDEySDVNMTIgMTlsLTctNyA3LTciPjwvcGF0aD48L3N2Zz4=" class="nav-icon" alt="Logout">
                        Back to Home
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
                    <h1>Manage Appointments</h1>
                </div>
                <div class="header-actions">
                    <div class="user-profile">
                        <div class="user-avatar">B</div>
                        <span>Professional Barber</span>
                    </div>
                </div>
            </div>
        </header>

        <!-- Dashboard Content -->
        <main class="dashboard-content">
            <div class="page-header">
                <div>
                    <h2 class="page-title">Appointment Details</h2>
                    <p class="page-subtitle">Manage and approve customer appointments</p>
                </div>
                <a href="barberdashboard.html" class="back-link">
                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTE5IDEySDVNMTIgMTlsLTctNyA3LTciPjwvcGF0aD48L3N2Zz4=" class="back-icon" alt="Back">
                    Back to Dashboard
                </a>
            </div>

            <!-- Appointment Statistics -->
            <div class="stats-summary">
                <div class="stat-card total">
                    <div class="stat-value" id="totalAppointments">0</div>
                    <div class="stat-label">Total Appointments</div>
                </div>
                <div class="stat-card pending">
                    <div class="stat-value" id="pendingAppointments">0</div>
                    <div class="stat-label">Pending</div>
                </div>
                <div class="stat-card confirmed">
                    <div class="stat-value" id="confirmedAppointments">0</div>
                    <div class="stat-label">Confirmed</div>
                </div>
                <div class="stat-card completed">
                    <div class="stat-value" id="completedAppointments">0</div>
                    <div class="stat-label">Completed</div>
                </div>
            </div>

            <div class="appointments-container">
                <table class="appointments-table">
                    <thead>
                        <tr>
                            <th>Appointment ID</th>
                            <th>Customer Name</th>
                            <th>Service Name</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection con = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            
                            int totalAppointments = 0;
                            int pendingCount = 0;
                            int confirmedCount = 0;
                            int completedCount = 0;

                            try {
                                con = ConnectDB.getConnect();
                                String sql = "SELECT a.aid, c.cname, s.sname, s.sdesc, s.sprice, a.status " +
                                             "FROM appointment a " +
                                             "JOIN customer c ON a.cid = c.cid " +
                                             "JOIN services s ON a.sid = s.sid";
                                ps = con.prepareStatement(sql);
                                rs = ps.executeQuery();

                                boolean hasData = false;

                                while (rs.next()) {
                                    hasData = true;
                                    totalAppointments++;
                                    String status = rs.getString("status");
                                    
                                    if ("pending".equalsIgnoreCase(status)) {
                                        pendingCount++;
                                    } else if ("confirmed".equalsIgnoreCase(status)) {
                                        confirmedCount++;
                                    } else if ("completed".equalsIgnoreCase(status)) {
                                        completedCount++;
                                    }
                                    
                                    String statusClass = "status-pending";
                                    if ("confirmed".equalsIgnoreCase(status)) {
                                        statusClass = "status-confirmed";
                                    } else if ("completed".equalsIgnoreCase(status)) {
                                        statusClass = "status-completed";
                                    } else if ("cancelled".equalsIgnoreCase(status)) {
                                        statusClass = "status-cancelled";
                                    }
                        %>
                        <tr>
                            <td><%= rs.getInt("aid") %></td>
                            <td>
                                <div class="customer-name"><%= rs.getString("cname") %></div>
                            </td>
                            <td>
                                <div class="service-name"><%= rs.getString("sname") %></div>
                            </td>
                            <td>
                                <div class="service-description"><%= rs.getString("sdesc") %></div>
                            </td>
                            <td>
                                <div class="service-price">$<%= rs.getDouble("sprice") %></div>
                            </td>
                            <td>
                                <span class="status-badge <%= statusClass %>"><%= rs.getString("status") %></span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="AppointmentAproved.jsp?aid=<%= rs.getInt("aid") %>" class="btn btn-approve">
                                        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTIwIDZMOSAxN2wtNS01Ij48L3BhdGg+PC9zdmc+" class="btn-icon" alt="Approve">
                                        Approve
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
                                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjOTRBM0I4IiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTkgNUg3YTIgMiAwIDAgMC0yIDJ2MTRhMiAyIDAgMCAwIDIgMmgxMGEyIDIgMCAwIDAgMi0yVjdhMiAyIDAgMCAwLTItMmgtMm0tOSA5aDZtLTYgNGg2bTgtNFY0bTAtNnY0Ij48L3BhdGg+PC9zdmc+" class="empty-icon" alt="No Appointments">
                                    <h3>No Appointments Found</h3>
                                    <p>There are currently no appointments in the system.</p>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (ps != null) ps.close();
                                if (con != null) con.close();
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
                    <p>Email: barber@barberqueue.com</p>
                    <p>Phone: +1 (555) 123-4567</p>
                    <p>Support: support@barberqueue.com</p>
                </div>
                
                <div class="footer-section">
                    <h4>Quick Links</h4>
                    <p><a href="barberdashboard.html">Barber Dashboard</a></p>
                    <p><a href="ManageServices.jsp">Manage Services</a></p>
                    <p><a href="addServices.html">Add Services</a></p>
                    <p><a href="index.html">Home Page</a></p>
                </div>
                
                <div class="footer-section">
                    <h4>Business Hours</h4>
                    <p>Monday - Friday: 8:00 AM - 8:00 PM</p>
                    <p>Saturday: 9:00 AM - 6:00 PM</p>
                    <p>Sunday: 10:00 AM - 4:00 PM</p>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2024 Barber Queue Management System. All rights reserved. | Privacy Policy | Terms of Service</p>
            </div>
        </footer>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Mobile menu toggle
            const mobileMenuToggle = document.getElementById('mobileMenuToggle');
            const sidebar = document.getElementById('sidebar');
            
            mobileMenuToggle.addEventListener('click', function() {
                sidebar.classList.toggle('mobile-open');
            });
            
            // Update appointment statistics
            document.getElementById('totalAppointments').textContent = <%= totalAppointments %>;
            document.getElementById('pendingAppointments').textContent = <%= pendingCount %>;
            document.getElementById('confirmedAppointments').textContent = <%= confirmedCount %>;
            document.getElementById('completedAppointments').textContent = <%= completedCount %>;
            
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
                alert('Barber profile menu would open here');
            });

            // Add loading animation to action buttons
            const actionButtons = document.querySelectorAll('.btn');
            actionButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    const originalHTML = this.innerHTML;
                    this.innerHTML = '<img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PGNpcmNsZSBjeD0iMTIiIGN5PSIxMiIgcj0iMTAiPjwvY2lyY2xlPjxwb2x5bGluZSBwb2ludHM9IjEyIDYgMTIgMTIgMTYuNSAxNCI+PC9wb2x5bGluZT48L3N2Zz4=" class="btn-icon" alt="Loading"> Processing...';
                    this.style.opacity = '0.8';
                    this.style.pointerEvents = 'none';
                    
                    setTimeout(() => {
                        this.innerHTML = originalHTML;
                        this.style.opacity = '1';
                        this.style.pointerEvents = 'auto';
                    }, 1500);
                });
            });
        });
    </script>
</body>
</html>