<%@page import="property_management.app.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manager Dashboard</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   <style>
   .content{
   	margin-top: 100px;
   	min-height: 60%;
   }
   		* {
    box-sizing: border-box; /* Ensure padding and borders are included in element's total width and height */
    margin: 0;
    padding: 0;
}
 
html, body {
    height: 100%; /* Full height for the body */
    font-family: 'Arial', sans-serif; /* Font for the entire page */
    display: flex; /* Flexbox layout */
    flex-direction: column; /* Stack elements vertically */
}
 
body {
    background-image: url('https://i.pinimg.com/originals/e8/9a/36/e89a365e1930ca5835309f64fa045af0.jpg'); /* Background image */
    background-size: cover; /* Cover the entire area */
    background-position: center; /* Center the image */
    background-repeat: no-repeat; /* Prevent repeating the image */
    min-height: 100%;
}
 
.content {
    flex: 1; /* Allow content to take up remaining space */
    display: flex; /* Flexbox for content alignment */
    justify-content: center; /* Center content horizontally */
    align-items: center; /* Center content vertically */
    padding: 20px; /* Padding around content */
    background: rgba(255, 255, 255, 0.2); /* Semi-transparent white background */
    border-radius: 12px; /* Rounded corners */
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2); /* Shadow for depth */
}
 
.dashboard-container {
    width: 100%; /* Full width for the dashboard container */
    max-width: 1200px; /* Maximum width */
    margin: auto; /* Center the container */
}
 
.btn-container {
    display: flex; /* Flexbox for button layout */
    flex-wrap: nowrap; /* Prevent wrapping */
    justify-content: center; /* Center the buttons */
    overflow-x: auto; /* Allow horizontal scrolling if needed */
    padding: 20px; /* Padding around button container */
}
 
.btn-card {
    background: rgba(255, 255, 255, 0.7); /* Semi-transparent white for cards */
    border-radius: 12px; /* Rounded corners */
    padding: 20px; /* Padding inside button cards */
    width: 200px; /* Fixed width for button cards */
    margin: 10px; /* Margin around button cards */
    text-align: center; /* Center text in button cards */
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); /* Shadow for depth */
    transition: transform 0.3s ease, background-color 0.3s ease, box-shadow 0.3s ease; /* Transition for hover effects */
    position: relative; /* Position for pseudo-element effect */
}
 
 
.btn-card:hover {
    transform: translateY(-5px); /* Lift effect on hover */
    background-color: rgba(0, 0, 0, 0.7); /* Change background on hover */
    color: white; /* Change text color on hover */
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3); /* Enhanced shadow on hover */
}
 
.btn-card h3 {
    margin-bottom: 10px; /* Space below the heading */
}
 
.btn-card a {
    text-decoration: none; /* Remove underline from links */
    color: white; /* Inherit text color */
    font-weight: bold; /* Bold text for links */
    display: block; /* Make link block level */
    margin-top: 10px; /* Space above links */
    padding: 10px 15px; /* Padding for clickable area */
    border-radius: 8px; /* Rounded corners for link buttons */
    background-color: rgba(0, 0, 0, 1); /* Initial background color */
    transition: background-color 0.3s ease; /* Transition for background change */
}
 
.btn-card a:hover {
    background-color: rgba(255, 255,255, 1); /* Darker on hover */
    color: black; /* Ensure text is white on hover */
}
 
 
 
 
footer {
    background-color: rgba(51, 51, 51, 0.8); /* Semi-transparent dark gray */
    color: white; /* White text */
    padding: 20px; /* Padding for footer */
    text-align: center; /* Center align text in footer */
}
 
.footer-content {
    display: flex; /* Flexbox for footer alignment */
    justify-content: space-between; /* Space out elements */
    align-items: center; /* Center vertically */
}
 
.social-icons {
    list-style-type: none; /* Remove bullet points */
    padding: 0; /* Remove padding */
    display: flex; /* Flexbox for icons */
}
 
.social-icons li {
    margin-left: 15px; /* Space between icons */
}
 
.footer-bottom {
    margin-top: 10px; /* Space above bottom text */
}
   		
   </style>
</head>
<body style="background-image: url('https://wallpaperaccess.com/full/1657789.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
 
<%@include file="header.jsp" %>
	<%
	User user = (User) request.getAttribute("user");
	%>
 
<div class="content">
 
	<!-- Dashboard Container -->
	<div class="dashboard-container">
		<div class="btn-container">
			<!-- Buttons for Manager Actions -->
			<div class="btn-card tenants">
				<h3>Manage Tenants</h3>
				<a href="/tenant/viewTenants">Manage Tenants</a>
			</div>
 
			<div class="btn-card requests">
				<h3>Manage Requests</h3>
				<a href="/getAssignRequests">Manage Requests</a>
 
			</div>
 
			<div class="btn-card payments">
				<h3>Manage Payments</h3>
				<a href="/getAssignedPayments">Manage Payments</a>
			</div>
 
			
 
 
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
</body>
</html>
 
 