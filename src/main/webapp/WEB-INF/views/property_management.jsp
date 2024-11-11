<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Property Management</title>
<!-- Linking the CSS file -->
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestyle.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   <style>
   		* {
    box-sizing: border-box; /* Include padding and border in element's total width and height */
    margin: 0;
    padding: 0;
}
 
body {
    font-family: 'Arial', sans-serif; /* Font for the entire page */
    background-color: #f4f4f4; /* Light background color for contrast */
    display: flex;
    flex-direction: column; /* Stack elements vertically */
    min-height: 100vh; /* Full height for body */
}
 
.content {
    flex: 1; /* Allow the content to take up remaining space */
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px; /* Padding around the content area */
    min-height: 80vh;
    margin-top: 70px;
}
 
.container {
	background: rgba(255, 255, 255, 0.5); /* Slight transparency */
    border-radius: 10px; /* Rounded corners */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Shadow for depth */
    padding: 30px; /* Padding inside container */
    width: 100%; /* Full width */
    max-width: 800px; /* Maximum width for the container */
    text-align: center; /* Center text inside container */
    min-height: 300px;
}
 
h1 {
    margin-bottom: 20px; /* Space below the heading */
    color: #333; /* Darker text for the heading */
    font-size: 2.5rem; /* Larger font size for heading */
}
 
.button-container {
    display: flex; /* Flexbox for button alignment */
    justify-content: space-around; /* Space buttons evenly */
    flex-wrap: wrap; /* Allow buttons to wrap on small screens */
    margin-top: 20px; /* Space above button container */
}
 
.button {
    background-color: #000000; /* Green background for buttons */
    color: white; /* White text for buttons */
    border: none; /* No border */
    border-radius: 5px; /* Rounded corners */
    padding: 15px 20px; /* Padding inside buttons */
    font-size: 1.2rem; /* Font size for button text */
    text-decoration: none; /* Remove underline */
    transition: background-color 0.3s, transform 0.2s; /* Transition for hover effects */
    display: inline-block; /* Allow setting dimensions */
}
 
.button:hover {
    background-color: #45a049; /* Darker green on hover */
    transform: translateY(-2px); /* Slight lift effect on hover */
}
 
   		
   </style>
</head>
<body
	style="background-image: url('https://wallpaperaccess.com/full/1657789.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
 
<%@include file="header.jsp" %>
 
 
	<div>
	<div class="content">
 
		<div class="container">
		<h1>Manage Property</h1>
 
 
        <div class="button-container">
        
        <a href="/property/openAddProperty" class="button">Add New Property</a>
        <a href="/landlord/PropertyPage" class="button">View Properties</a>
			<a href="/user/landlord_dashboard" class="button">Back to Dashboard</a>			
            
			<a href="/user/logout" class="button">Logout</a>
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
 
 