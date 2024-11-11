<%@ page import="java.util.List" %>
<%@ page import="property_management.app.entities.Property" %>
<%@page import="property_management.app.entities.User"%>


<%
List<Property> properties = (List<Property>) request.getAttribute("properties");
List<String> locations = (List<String>) request.getAttribute("locations");
List<String> facilities = (List<String>) request.getAttribute("facilities");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Management System - Properties</title>
    <link href="${pageContext.request.contextPath}/css/homestyle.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<style type="text/css">
.content {
	margin-top: 150px;
}

.btn-primary{
	margin-top:40px;
	max-height: 40px;
}

</style>


</head>
<body>

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

	<!-- Search Bar and Filter Form -->
	<section class="filter-section">
		<form action="${pageContext.request.contextPath}/property/PropertyPage"
			method="GET">
			<!-- Search by Title -->
			<div class="form-group">
				<label for="search">Search Property</label> <input type="text"
					name="search" id="search" placeholder="Search by property title"
					value="<%=request.getParameter("search") != null ? request.getParameter("search") : ""%>" />
			</div>

			<!-- Filter by Location -->
			<div class="form-group">
				<label for="location">Location</label> <select name="location"
					id="location">
					<option value="">All Locations</option>
					<%
					String selectedLocation = request.getParameter("location");
					%>
					<%
					for (String location : locations) {
					%>
					<option value="<%=location%>"
						<%=location.equals(selectedLocation) ? "selected" : ""%>><%=location%></option>
					<%
					}
					%>
				</select>
			</div>

			<!-- Filter by Facilities (Checkboxes) -->
			<div class="form-group">
				<label for="facilities">Facilities</label>
				<div class="custom-dropdown">
					<button type="button" class="dropdown-btn">Select
						Facilities</button>
					<div class="dropdown-content">
						<div class="checkboxes">
							<%
							String[] selectedFacilities = request.getParameterValues("facilities");
							%>
							<%
							for (String facility : facilities) {
							%>
							<label> <input type="checkbox" name="facilities"
								value="<%=facility%>"
								<%=selectedFacilities != null && java.util.Arrays.asList(selectedFacilities).contains(facility) ? "checked" : ""%> />
								<%=facility%>
							</label>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>


			<!-- Submit Button -->
				<button type="submit" class="btn-primary">Search</button>
		</form>
	</section>

	<div class="content">

		<!-- Cards Section: Property Listings -->
		<section class="cards-container">
			<div class="cards-title">
				<h2>Available Properties</h2>
			</div>

			<div class="cards">
				<!-- If no properties are available, show a message -->
				<%
				if (properties == null || properties.isEmpty()) {
				%>
				<p>No properties available at the moment.</p>
				<%
				} else {
				%>
				<!-- Loop through properties and display each one as a card -->
				<%
				for (Property property : properties) {
				%>
				<div class="card">
					<!-- Property Image -->
					<img
						src="<%=(property.getImageAsBase64() != null && !property.getImageAsBase64().isEmpty())
		? "data:image/jpeg;base64," + property.getImageAsBase64()
		: "/images/default-image.png"%>"
						alt="Image of <%=property.getTitle()%>">

					<!-- Property Title -->
					<h3><%=property.getTitle()%></h3>

					<!-- Property Description -->
					<p><%=property.getDescription()%></p>

					<!-- Property Price -->
					<p>
						Price: ₹<%=String.format("%.2f", property.getPrice())%></p>

					<!-- Property Details Button -->
					<a
						href="${pageContext.request.contextPath}/property/PropertyDetails/<%= property.getPropertyId() %>"
						class="btn-secondary">View Details</a>
				</div>
				<%
				}
				%>
				<%
				}
				%>
			</div>
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



	<script type="text/javascript">
		document
				.addEventListener('DOMContentLoaded',
						function() {
							const dropdownBtn = document
									.querySelector('.dropdown-btn');
							const dropdownContent = document
									.querySelector('.dropdown-content');
							const submitButton = document
									.querySelector('button[type="submit"]'); // Select the submit button

							// Toggle dropdown content visibility on button click
							dropdownBtn.addEventListener('click', function() {
								dropdownContent.classList.toggle('show');
							});

							// Close the dropdown if the user clicks outside of it
							window.onclick = function(event) {
								if (!event.target.matches('.dropdown-btn')
										&& !event.target
												.closest('.dropdown-content')) {
									if (dropdownContent.classList
											.contains('show')) {
										dropdownContent.classList
												.remove('show');
									}
								}
							};

							// Close the dropdown when the submit button is clicked
							submitButton.addEventListener('click',
									function() {
										if (dropdownContent.classList
												.contains('show')) {
											dropdownContent.classList
													.remove('show');
										}
									});
						});
	</script>



</body>
</html>
