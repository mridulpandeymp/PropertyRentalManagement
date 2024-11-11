<%@page import="property_management.app.entities.User"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">






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
			User loggedInUser = (User) session.getAttribute("loggedInUser");
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