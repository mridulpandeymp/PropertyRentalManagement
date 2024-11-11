<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Landlord Dashboard</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
body {
	display: flex;
	flex-direction: column;
	min-height: 100vh; /* Full height */
	margin: 0; /* Remove default margin */
	font-family: Arial, sans-serif; /* Font for better readability */
	background: linear-gradient(to bottom right, #e0f7fa, #ffffff);
	/* Gradient background */
}

.content {
	flex: 1; /* Allow content area to grow */
	margin-top: 180px; /* Space above content */
	background: rgba(255, 255, 255, 0.2); /* Slight transparency */
	padding: 30px; /* Increased padding */
	border-radius: 10px; /* Rounded corners */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2); /* Subtle shadow */
	overflow-y: auto;
	margin-bottom: 160px;
}

.container {
	display: flex;
	flex-direction: column;
	align-items: center; /* Center items horizontally */
}

h1 {
	color: #333; /* Darker color for contrast */
	margin-bottom: 20px; /* Spacing below title */
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1); /* Soft shadow for text */
}

.button-container {
	display: flex; /* Use flexbox for a single line */
	flex-wrap: wrap; /* Allow wrapping for smaller screens */
	justify-content: center; /* Center buttons */
	gap: 20px; /* Space between buttons */
	width: 100%; /* Full width for buttons */
	max-width: 800px; /* Limit width */
}

.button {
	background-color: #000000; /* Button color */
	color: white;
	width: 200px; /* Fixed width for all buttons */
	padding: 15px; /* Adjusted padding for uniform height */
	height: 60px; /* Fixed height for uniformity */
	border-radius: 10px; /* More rounded corners */
	text-decoration: none;
	transition: background-color 0.3s, transform 0.3s;
	/* Smooth transitions */
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Button shadow */
	font-size: 1.1em; /* Increase font size */
	display: flex;
	align-items: center; /* Center icon and text */
	justify-content: center; /* Center button content */
	position: relative; /* Position for pseudo-element */
	overflow: hidden; /* Hide overflow */
}

.button::after {
	content: ''; /* Create an underline effect */
	position: absolute;
	width: 100%;
	height: 4px; /* Height of underline */
	background: rgba(255, 255, 255, 0.5); /* Light color for underline */
	bottom: 0;
	left: 0;
	transform: translateY(100%); /* Start off-screen */
	transition: transform 0.3s; /* Smooth transition */
}

.button:hover {
	background-color: #0056b3; /* Darker shade on hover */
	transform: translateY(-3px); /* Lift effect on hover */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	/* Enhanced shadow on hover */
}

.button:hover::after {
	transform: translateY(0); /* Slide in effect on hover */
}

a {
	text-align: center; /* Center text for buttons */
}

/* Removed the margin-top for logout button to align it */
a.logout {
	display: inline-block; /* Make it block for spacing */
	font-weight: bold; /* Bold text for logout */
}
</style>
</head>
<body
	style="background-image: url('https://wallpaperaccess.com/full/1657789.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">

	<%@include file="header.jsp"%>
	<div>
		<div class="content">
			<div class="container">
				<h1>Landlord Dashboard</h1>

				<div class="button-container">
					<a href="/landlord/openPropertyManagement" class="button">Manage
						Properties</a> <a href="/landlord/manageManagers" class="button">Manage
						Managers</a> <a href="/tenant/viewTenants" class="button">Manage
						Tenants</a> <a href="/maintenance-requests" class="button">View
						Maintenance Requests</a>
						<a href="/landlord/getAllPayments" class="button">Payment 
						Records</a>
				</div>
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
	</div>

</body>
</html>


