<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>User Login Page</title>
	    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
	</head>
<body>

	<%@include file="header.jsp" %>
	
	
	<div class="content">

	<form action="/user/login" method="post">
		<input type="text" name="username" placeholder="Enter username" /><br /> 
		<input type="password" name="password" placeholder="Enter password" /><br />
		<input type="submit" value="Submit" />
		<p>Not Registered? </p>
		<p>Click <a href = "/user/openTenantRegistrationPage">here</a> to register as Tenant</p>
		<p>Click <a href = "/user/openManagerRegistrationPage">here</a> to register as Manager</p>
	</form>
	</div>
	
	
	
	<%@include file="message.jsp" %>
	<%@include file="footer.jsp" %>

</body>
</html> --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Login Page</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
.content {
	max-height: 100%;
	margin-top: 80px;
}

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

html, body {
	height: 100%; /* Full height for the body */
	display: flex; /* Use flexbox for layout */
	flex-direction: column; /* Stack elements vertically */
}

body {
	font-family: 'Arial', sans-serif;
	background-size: cover; /* Cover the entire area */
	background-position: center; /* Center the image */
	background-repeat: no-repeat; /* Prevent repeating the image */
}

.content {
	flex: 1; /* Allow content to take up remaining space */
	display: flex; /* Use flexbox for content alignment */
	align-items: center; /* Center content vertically */
	justify-content: center; /* Center content horizontally */
	padding: 20px; /* Add padding around the content */
}

form {
	width: 400px; /* Fixed width for the form */
	background: rgba(255, 255, 254, 0.8); /* Semi-transparent white */
	padding: 30px; /* Increased padding for better spacing */
	border-radius: 12px; /* More rounded corners */
	box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1); /* Enhanced shadow */
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	/* Smooth transitions */
}

h2 {
	text-align: center; /* Center the heading */
	margin-bottom: 20px; /* Margin below the heading */
	color: #333; /* Dark color for the heading */
}

input[type="text"], input[type="password"], input[type="submit"] {
	width: 100%; /* Full width for inputs */
	padding: 15px; /* Increased padding for a better touch target */
	margin: 15px 0; /* Margin between inputs */
	border: 2px solid #ccc; /* Slightly thicker border for inputs */
	border-radius: 8px; /* More rounded corners */
	transition: border-color 0.3s ease, box-shadow 0.3s ease;
	/* Smooth transition */
}

input[type="text"]:focus, input[type="password"]:focus {
	border-color: #007bff; /* Change border color on focus */
	box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Subtle glow effect */
	outline: none; /* Remove default outline */
}

input[type="submit"] {
	background-color: #28a745; /* Button color */
	color: white;
	border: none;
	cursor: pointer;
	font-weight: bold; /* Bold text for the button */
	padding: 15px; /* Increased padding */
	border-radius: 8px; /* Rounded corners */
	transition: background-color 0.3s ease, transform 0.3s ease;
	/* Smooth transitions */
}

input[type="submit"]:hover {
	background-color: #218838; /* Darker on hover */
	transform: translateY(-2px); /* Lift effect on hover */
}

p {
	text-align: center; /* Center align paragraph text */
	margin-top: 10px; /* Margin above paragraphs */
	color: #555; /* Dark gray text color */
	font-size: 14px; /* Slightly larger font size */
}

a {
	color: #007bff; /* Link color */
	text-decoration: none; /* Remove underline */
}

a:hover {
	text-decoration: underline; /* Underline on hover */
}
</style>
</head>
<body
	style="background-image: url('https://wallpaperaccess.com/full/3124512.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">

	<%@include file="header.jsp"%>

	<div class="content">
		<form action="/user/login" method="post">
			<h2>Login</h2>
			<!-- Added Login heading -->
			<input type="text" name="username" placeholder="Enter username" /><br />
			<input type="password" name="password" placeholder="Enter password" /><br />
			<input type="submit" value="Submit" />
			<%@include file="message.jsp"%>
			<p>Not Registered?</p>
			<p>
				Click <a href="/user/openTenantRegistrationPage">here</a> to
				register as Tenant
			</p>
			<p>
				Click <a href="/user/openManagerRegistrationPage">here</a> to
				register as Manager
			</p>
		</form>

	</div>
	<center style=>
		<a href="/user/forgotPassword">
			<button>Forgot Password</button>
		</a>
	</center>

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

