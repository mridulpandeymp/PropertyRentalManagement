<%@page import="property_management.app.entities.User"%>
<%@page import="property_management.app.entities.Property"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Tenant Dashboard">
<title>Tenant Dashboard</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">

<style>

/* Dropdown styling */
.dropdown {
	position: relative;
	display: inline-block;
}

.dropbtn {
	background-color: #333;
	color: white;
	padding: 10px;
	border: none;
	cursor: pointer;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: white;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content a:hover {
	background-color: #ddd;
}

.dropdown:hover .dropdown-content {
	display: block;
}
</style>

</head>
<body
	style="background-image: url('https://directlinedev.com/media/cases/rooney/header/background_1_zM58lsj.desktop.jpeg');">


	<!-- Check for user session and cache control -->
	<%
	// Cache control
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
	response.setDateHeader("Expires", 0); // Proxies.

	// Check if the user is logged in
	User loggedInUser = (User) session.getAttribute("loggedInUser");
	if (loggedInUser == null) {
		response.sendRedirect("/user/openLoginPage");
		return; // Stop processing the rest of the page
	}
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

	<!-- Dashboard Section -->
	<section class="dashboard-section">
		<div class="dashboard-container">

			<!-- View Property Card -->
			<div class="dashboard-card">
				<h2>View My Property</h2>
				<p>Check the details of the property you're currently renting.</p>

				<%
				// Fetch the list of properties assigned to the logged-in user
				Integer propertyId = (Integer) request.getAttribute("propertyId");
				String status = (String) request.getAttribute("status");

				// Check if propertyId is not null and status is "pending"
				if (propertyId != null && "pending".equals(status)) {
					// Redirect to another URL (modify the URL as needed)
				%>
				<a href="/property/PropertyDetails/<%=propertyId%>"
					class="btn-primary">View Applied Property</a>
				<%
				} else if (propertyId != null) {
				%>
				<a href="/property/PropertyDetails/<%=propertyId%>"
					class="btn-primary">View Property</a>
				<%
				} else {
				%>
				<p>You don't have a property assigned yet.</p>
				<%
				}
				%>
			</div>


			<!-- Manage Lease Card -->
			<div class="dashboard-card">
				<h2>Manage Lease</h2>
				<p>Access and review your lease agreement.</p>
				<a href="/lease-agreements/myLeaseAgreements" class="btn-primary">View
					Lease Agreement</a>
			</div>

			<!-- Payments & Invoices Card -->
			<div class="dashboard-card">
				<h2>Payments & Invoices</h2>
				<p>Make rental payments and review invoices.</p>
				<a href="/tenant/paymentPage" class="btn-primary">Make Payment</a>
			</div>

			<!-- Maintenance Requests Card -->
			<div class="dashboard-card">
				<h2>Request Maintenance</h2>
				<p>Submit a request for maintenance or repairs.</p>
				<a href="/tenant/maintenanceRequest" class="btn-primary">Request
					Maintenance</a>
			</div>

			<!-- Profile & Settings Card -->
			<div class="dashboard-card">
				<h2>Profile & Settings</h2>
				<p>View and update your profile information.</p>
				<a href="/user/viewProfile" class="btn-primary">Profile</a>
			</div>

		</div>
	</section>

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
