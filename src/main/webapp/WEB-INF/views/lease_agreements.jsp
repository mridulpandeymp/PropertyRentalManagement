<%@ page import="java.util.List"%>
<%@ page import="property_management.app.entities.LeaseAgreement"%>
<%@page import="property_management.app.entities.User"%>


<%
List<LeaseAgreement> leaseAgreements = (List<LeaseAgreement>) request.getAttribute("leaseAgreements");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Lease Agreements</title>
<link href="${pageContext.request.contextPath}/css/homestyle.css" rel="stylesheet"/>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>/* Table Styling */
.lease-table {
	width: 100%;
	border-collapse: collapse; /* Collapse borders for a cleaner look */
	margin-top: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
}

.lease-table th, .lease-table td {
	padding: 15px;
	text-align: left; /* Align text to the left */
	border: 1px solid #ddd; /* Add a border for cells */
}

.lease-table th {
	background-color: #f1c40f; /* Header background color */
	color: #fff; /* Header text color */
	font-weight: bold; /* Bold header text */
}

.lease-table tr:hover {
	background-color: #f2f2f2; /* Hover effect for rows */
}
</style>

</head>
<body>

	
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
				<li class="dropdown">
					<a href="#" class="dropbtn"><%= loggedInUser.getFirstName() %></a>
					<div class="udropdown-content">
						<a href="/user/<%= roleDashboard %>">Dashboard</a>
						<a href="/user/viewProfile">View Profile</a>
						<a href="/user/logout">Logout</a>
					</div>
				</li>
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
		<!-- Lease Agreements Section -->
		<section class="lease-agreements-section">
			<div class="section-title">
				<h2>Lease Agreements</h2>
			</div>

			<table class="lease-table">
				<thead>
					<tr>
						<th>Lease ID</th>
						<th>Tenant ID</th>
						<th>Property</th>
						<th>Lease Start Date</th>
						<th>Lease End Date</th>
						<th>Rent Amount</th>
						<th>Deposit Amount</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (leaseAgreements == null || leaseAgreements.isEmpty()) {
					%>
					<tr>
						<td colspan="10">No lease agreements available at the moment.</td>
					</tr>
					<%
					} else {
					%>
					<%
					for (LeaseAgreement lease : leaseAgreements) {
					%>
					<tr>
						<td><%=lease.getLeaseId()%></td>
						<td><%=lease.getTenantId()%></td>
						<td><a
							href="${pageContext.request.contextPath}/property/PropertyDetails/<%= lease.getPropertyId() %>">Property
								Details</a></td>
						<td><%=lease.getLeaseStartDate()%></td>
						<td><%=lease.getLeaseEndDate()%></td>
						<td><%=lease.getRentAmount()%></td>
						<td><%=lease.getSecurityDeposit()%></td>
						<td><%=lease.getStatus()%></td>
						<td><a
							href="<%=request.getContextPath() + "/lease-agreements/" + lease.getLeaseId()%>"
							class="btn-secondary">View Details</a></td>

						<%
						}
						%>
						<%
						}
						%>
					
				</tbody>
			</table>
		</section>
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
