<%@ page import="property_management.app.entities.Property"%>
<%@ page import="property_management.app.entities.User"%>
<%@ page import="property_management.app.entities.Tenant"%>
<%
    Integer propertyID = (Integer) request.getAttribute("propertyID"); // Retrieve propertyID if available
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    Property property = (Property) request.getAttribute("property");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description"
	content="View Property Details - Tenant Management System" />
<title>View Property | Tenant Management System</title>
<link href="${pageContext.request.contextPath}/css/homestyle.css"
	rel="stylesheet" />
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
/* Body styling */
body {
	background-image:
		url("/images/wallpapersden.com_gradient-landscape-4k-illustration_2048x1512.jpg");
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	font-family: "Arial", sans-serif;
	color: #333;
	margin: 0;
	padding: 0;
	line-height: 1.6;
	min-height: 200vh;
	overflow-y: auto;
}

/* Header styling */
header {
	background-color: rgba(240, 241, 243, 0.8);
	color: black;
	padding: 20px;
	text-align: center;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	position: relative;
	margin-top: 70px;
}

/* Property details styling */
.my-property-details {
	max-width: 800px;
	margin: 20px auto;
	padding: 20px;
	background: white;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.my-property-details h2 {
	color: #333;
}

.my-property-details img {
	max-width: 100%;
	height: auto;
	border-radius: 10px;
}

.my-property-info {
	margin: 20px 0;
}

.btn-back, .btn-rent {
	display: inline-block;
	padding: 10px 20px;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.btn-back {
	background-color: #007bff;
	color: white;
	text-decoration: none;
}

.btn-back:hover {
	background-color: #0056b3;
}

.btn-rent {
	background-color: #28a745;
	color: white;
	text-decoration: none;
}

.btn-rent:hover {
	background-color: #218838;
}

.my-facility-list {
	list-style-type: none;
	padding: 0;
}

.facility-item {
	display: flex;
	align-items: center;
}

.facility-icon {
	margin-right: 10px;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	cursor: pointer;
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

	<header>
		<h2>Property Details</h2>
	</header>

	<div class="content">
		<div class="my-property-details">
			<%
			if (property != null) {
			%>

			<img
				src="<%=(property.getpropertyImage() != null && property.getpropertyImage().length > 0)
		? "data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(property.getpropertyImage())
		: "/images/default-image.png"%>"
				alt="<%=property.getTitle() != null ? property.getTitle() : "Image"%>" />

			<div class="my-property-info">
				<p>
					<strong>Title:</strong>
					<%=property.getTitle()%></p>
				<p>
					<strong>Description:</strong>
					<%=property.getDescription()%></p>
				<p>
					<strong>Location:</strong>
					<%=property.getLocation()%></p>
				<p>
					<strong>Price:</strong> $<%=property.getPrice()%></p>
				<p>
					<strong>Facilities:</strong>
				</p>
				<ul class="my-facility-list">
					<li class="facility-item"><span class="facility-icon"><%=property.isSwimmingPool() ? "✔" : "✖"%></span>
						Swimming Pool</li>
					<li class="facility-item"><span class="facility-icon"><%=property.isGym() ? "✔" : "✖"%></span>
						Gym</li>
					<li class="facility-item"><span class="facility-icon"><%=property.isParking() ? "✔" : "✖"%></span>
						Parking</li>
					<li class="facility-item"><span class="facility-icon"><%=property.isGarden() ? "✔" : "✖"%></span>
						Garden</li>
					<li class="facility-item"><span class="facility-icon"><%=property.isAirConditioning() ? "✔" : "✖"%></span>
						Air Conditioning</li>
					<li class="facility-item"><span class="facility-icon"><%=property.isElevator() ? "✔" : "✖"%></span>
						Elevator</li>
					<li class="facility-item"><span class="facility-icon"><%=property.isSecuritySystem() ? "✔" : "✖"%></span>
						Security System</li>
					<li class="facility-item"><span class="facility-icon"><%=property.isInternet() ? "✔" : "✖"%></span>
						Internet</li>
					<li class="facility-item"><span class="facility-icon"><%=property.isFurnished() ? "✔" : "✖"%></span>
						Furnished</li>
				</ul>
			</div>
			<%
			} else {
			%>
			<p>No property details available.</p>
			<%
			}
			%>

			<div class="button-container" style="display: flex; justify-content: space-between;">
			    <a href="javascript:void(0);" class="btn-back" onclick="window.history.back();">Back</a>
			
			    <% if (propertyID != null) { %>
			        <!-- If the user is logged in and already renting a property -->
			       <a href="${pageContext.request.contextPath}/landlord/deleteProperty/<%= property.getPropertyId() %>"
						class="btn-secondary">Delete</a>

			    <% } else if (loggedInUser != null) { %>
			        <!-- If the user is logged in but not renting a property -->
			        <a href="${pageContext.request.contextPath}/landlord/deleteProperty/<%= property.getPropertyId() %>"
						class="btn-secondary">Delete</a>
			    <% } else { %>
			        <!-- If the user is not logged in -->
			        
			    <% } %>
			</div>


			


			<!-- Already Renting Modal -->
			<div id="alreadyRentingModal" class="modal">
			    <div class="modal-content">
			        <span class="close" onclick="closeAlreadyRentingModal()">&times;</span>
			        <h2>Delete Property</h2>
			        <p>Are you sure to delete this property.</p>
			        <button type="button" class="btn-back" onclick="closeAlreadyRentingModal()">Close</button>
			    </div>
			</div>


		</div>
	</div>

	<script>
	
	function redirectAfterSubmit(event) {
	    // Prevent the form from submitting normally
	    event.preventDefault();
	    
	    // Submit the form via AJAX
	    fetch('/tenant/submitRentalRequest', {
	        method: 'POST',
	        body: new FormData(event.target)
	    }).then(response => {
	        if (response.ok) {
	            // Redirect to the tenant registration page after successful submission
	            window.location.href = "/tenant/addTenantDetails";  // Your target URL
	        } else {
	            alert('There was an error submitting your request. Please try again.');
	        }
	    }).catch(error => {
	        console.error('Error:', error);
	        alert('An error occurred while processing your request.');
	    });

	    return false; // Prevent normal form submission
	}
	
	function openConfirmationModal() {
	    document.getElementById("rentConfirmationModal").style.display = "block";
	}

	function closeConfirmationModal() {
	    document.getElementById("rentConfirmationModal").style.display = "none";
	}

	function openAlreadyRentingModal() {
	    document.getElementById("alreadyRentingModal").style.display = "block";
	}

	function closeAlreadyRentingModal() {
	    document.getElementById("alreadyRentingModal").style.display = "none";
	}

	</script>
</body>
</html>
