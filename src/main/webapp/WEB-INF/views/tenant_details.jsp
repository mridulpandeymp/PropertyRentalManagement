<%@page import="property_management.app.entities.User"%>
<%@ page import="property_management.app.entities.Tenant"%>

<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestyle.css">
<style>
	/* Content styling */
.content {
    margin-top: 80px;
    padding: 20px;
    background-color: #f9f9f9; /* Light background for contrast */
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Form container styling */
.form-container {
    max-width: 600px;
    margin: 0 auto; /* Center the form */
}

/* Form group styling */
.form-group {
    margin-bottom: 20px; /* Space between form groups */
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px; /* Space below label */
    color: #333; /* Dark color for readability */
}

.form-group select,
.form-group input[type="number"] {
    width: 100%; /* Full-width input */
    padding: 10px;
    border: 1px solid #ccc; /* Light border */
    border-radius: 4px; /* Rounded corners */
    font-size: 16px; /* Font size */
}

.form-group select:focus,
.form-group input[type="number"]:focus {
    border-color: #007bff; /* Change border color on focus */
    outline: none; /* Remove default outline */
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Subtle shadow */
}

/* Button styling */
.form-actions {
    display: flex;
    justify-content: space-between; /* Space between buttons */
}

.btn-submit {
    background-color: #28a745; /* Green background */
    color: white; /* White text */
    border: none; /* Remove border */
    padding: 10px 20px; /* Padding for button */
    border-radius: 5px; /* Rounded corners */
    font-size: 16px; /* Font size */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s; /* Smooth transition */
}

.btn-submit:hover {
    background-color: #218838; /* Darker green on hover */
}

.btn-cancel {
    background-color: #dc3545; /* Red background */
    color: white; /* White text */
    border: none; /* Remove border */
    padding: 10px 20px; /* Padding for button */
    border-radius: 5px; /* Rounded corners */
    font-size: 16px; /* Font size */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s; /* Smooth transition */
}

.btn-cancel:hover {
    background-color: #c82333; /* Darker red on hover */
}

/* Message styling */
.success-message, .error-message {
    margin-top: 20px;
    padding: 10px;
    border-radius: 5px;
    text-align: center;
}

.success-message {
    background-color: #d4edda; /* Light green background */
    color: #155724; /* Dark green text */
}

.error-message {
    background-color: #f8d7da; /* Light red background */
    color: #721c24; /* Dark red text */
}

</style>
<title>Tenant Registration</title>
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
	<center><h2>Tenant Registration Form</h2></center>
	<div class="form-container">
		<form action="${pageContext.request.contextPath}/tenant/save"
			method="POST">
			<div class="form-group">
				<label for="tenantType">Tenant Type:</label> <select id="tenantType"
					name="tenantType" required>
					<option value="">Select Tenant Type</option>
					<option value="family">Family</option>
					<option value="bachelor">Bachelor</option>
					<option value="working_bachelor">Working Bachelor</option>
				</select>
			</div>

			<div class="form-group">
				<label for="noOfPersons">Number of Persons:</label> <input
					type="number" id="noOfPersons" name="noOfPersons" min="1" required>
			</div>

			<input type="hidden" name="tenantStatus" value="pending">
			<!-- default status -->
		   <input type="hidden" name="propertyId" value="${property.propertyId}">
			<!-- example property ID -->
			<input type="hidden" name="userId"
				value="${loggedInUser.getUserId()}">
			<!-- use logged-in user's ID -->

			<div class="form-actions">
				<button type="submit" class="btn-submit">Submit</button>
				<button type="button" class="btn-cancel"
					onclick="window.location.href='${pageContext.request.contextPath}/property/PropertyPage'">Cancel</button>
			</div>
		</form>
	</div>

	<!-- Success Message (displayed after form submission) -->
	<%
	if (request.getAttribute("successMessage") != null) {
	%>
	<div class="success-message">
		<p><%=request.getAttribute("successMessage")%></p>
	</div>
	<%
	}
	%>

	<!-- Validation Error Messages -->
	<%
	if (request.getAttribute("errorMessage") != null) {
	%>
	<div class="error-message">
		<p><%=request.getAttribute("errorMessage")%></p>
	</div>
	<%
	}
	%>

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
