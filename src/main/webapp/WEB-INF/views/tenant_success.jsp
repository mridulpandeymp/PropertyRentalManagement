<%@page import="property_management.app.entities.User"%>
<%@ page import="property_management.app.entities.Tenant"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Success - Tenant Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestyle.css">
    
    <style>
        .content {
            margin-top: 80px;
            padding: 20px;
            background-color: #f9f9f9; /* Light background for contrast */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 20px;
            max-width: 600px;
            margin: auto;
        }
        h2 {
            color: #4CAF50;
        }
        .btn {
            padding: 10px 20px;
            margin: 10px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .summary {
            margin: 20px 0;
            text-align: left;
        }
    </style>
</head>
<body>
    <!-- Check for user session and cache control -->
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            response.sendRedirect("/user/openLoginPage");
            return;
        }
        
        // Fetch attributes from request
        String tenantType = (String) request.getAttribute("tenantType");
        Integer noOfPersons = (Integer) request.getAttribute("noOfPersons");
        Integer propertyId = (Integer) request.getAttribute("propertyId");
        /* Integer tenantId = (Integer) request.getAttribute("tenantId"); */
    %>
    
    
	<!-- Constant Navigation Bar -->
	<nav class="navbar">
		<div class="navbar-container">
			<a href="#" class="logo">Property Management</a>
			<ul class="nav-links">
				<li><a href="/">Home</a></li>
				<li><a href="/property/PropertyPage">Properties</a></li>
				<li><a href="/aboutUs">About Us</a></li>
				<li><a href="/contact">Contact</a></li>

				<%
				if (loggedInUser != null) {
					String roleDashboard = "";
					int roleId = loggedInUser.getRole().getRoleId();
					if (roleId == 1) {
						roleDashboard = "landlord_dashboard";
					} else if (roleId == 2) {
						roleDashboard = "manager_dashboard";
					} else if (roleId == 3) {
						roleDashboard = "tenantDashboard";
					}
				%>
				<li class="dropdown"><a href="#" class="dropbtn"><%=loggedInUser.getFirstName()%></a>
					<div class="udropdown-content">
						<a href="/user/<%=roleDashboard%>">Dashboard</a> <a
							href="/user/viewProfile">View Profile</a> <a href="/user/logout">Logout</a>
					</div></li>
				<%
				} else {
				%>
				<li><a href="/user/openLoginPage" class="login-btn">Login</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</nav>
    

    <div class="content">
        <div class="container">
            <h2>Your tenant registration has been submitted successfully!</h2>
            <p>Thank you for registering your tenant details.</p>
            
            <div class="summary">
                <h3>Submission Summary:</h3>
                <ul>
                    <li><strong>Tenant Type:</strong> <%= tenantType %></li>
                    <li><strong>Number of Persons:</strong> <%= noOfPersons %></li>
                    <li><strong>Tenant Status:</strong> Pending</li>
                    <li><strong>Property ID:</strong> <%= propertyId %></li>
                   <%--  <li><strong>Tenant ID:</strong> <%= tenantId %></li> --%>
                </ul>
            </div>
            
            <a class="btn" href="${pageContext.request.contextPath}/user/tenantDashboard">Go to Dashboard</a>
            <a class="btn" href="${pageContext.request.contextPath}/property/PropertyPage">Back to Properties</a>
        </div>
    </div>

    <!-- Footer Section -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-left">
                <h3>Property Management</h3>
                <p>Your one-stop solution for managing and finding properties.</p>
            </div>
            <div class="footer-right">
                <ul class="social-icons">
                    <li><a href="#"><i class="fab fa-facebook"></i></a></li>
                    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                    <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                    <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 Property Management System. All Rights Reserved.</p>
        </div>
    </footer>
</body>
</html>
