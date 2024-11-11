 
 
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manager Registration Page</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f5f5f5; /* Light gray background */
	margin: 0; /* Remove default margin */
	display: flex;
	flex-direction: column;
	/* Arrange header, content, and footer vertically */
	min-height: 100vh; /* Ensure body takes full height */
	background-image:
		url('https://img.freepik.com/premium-photo/top-view-workspace-with-blank-notebook-pen-wooden-table_93675-145125.jpg');
	background-size: cover; /* Cover the full background */
	background-position: center; /* Center the background */
	background-repeat: no-repeat; /* No repeat */
}
 
.content {
	flex: 1; /* Allow content to grow and take available space */
	display: flex;
	flex-direction: column; /* Align children vertically */
	align-items: center; /* Center align items */
	justify-content: center; /* Center vertically */
	padding: 20px; /* Add some padding */
	margin-top: 70px; /* Adjust top margin */
}
 
form {
	background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
	padding: 30px; /* Add padding */
	border-radius: 12px; /* Rounded corners */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Subtle shadow */
	width: 400px; /* Fixed width for the form */
	box-sizing: border-box; /* Include padding in width */
}
 
input[type="text"], input[type="password"], input[type="date"], input[type="file"]
	{
	width: 100%; /* Full width */
	padding: 10px;
	margin: 10px 0; /* Spacing between inputs */
	border: 1px solid #ccc; /* Light gray border */
	border-radius: 5px; /* Rounded corners */
	box-sizing: border-box; /* Include padding in width */
}
 
input[type="submit"] {
	background-color: #28a745; /* Green button */
	color: white;
	padding: 10px;
	border: none;
	border-radius: 5px; /* Rounded corners */
	cursor: pointer;
	width: 100%; /* Full width */
	transition: background-color 0.3s ease; /* Smooth transition */
}
 
input[type="submit"]:hover {
	background-color: #218838; /* Darker green on hover */
}
 
p {
	text-align: center;
	margin-top: 20px;
}
 
a {
	color: #007bff; /* Link color */
	text-decoration: none; /* Remove underline */
}
 
a:hover {
	text-decoration: underline; /* Underline on hover */
}
 
/* Footer Styles */
.footer {
	background-color: #333; /* Dark background */
	color: white; /* White text */
	padding: 20px; /* Padding */
	position: relative; /* Positioning */
	bottom: 0; /* Align at bottom */
	width: 100%; /* Full width */
}
 
.footer-content {
	display: flex; /* Flexbox for alignment */
	justify-content: space-between; /* Space out elements */
	align-items: center; /* Center align items */
}
 
.footer-left h3 {
	margin: 0; /* Remove margin */
}
 
.footer-right .social-icons {
	list-style-type: none; /* Remove bullet points */
	padding: 0; /* Remove padding */
	display: flex; /* Flexbox for icons */
}
 
.footer-right .social-icons li {
	margin-left: 15px; /* Space between icons */
}
 
.footer-bottom {
	text-align: center; /* Center text */
	margin-top: 10px; /* Space above */
}
</style>
<script>
        function validateForm() {
            // Validate email
            const email = document.forms["managerForm"]["emailId"].value;
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }
 
          
            
            const mobileNo = document.forms["managerForm"]["mobileNo"].value;
            const mobilePattern = /^\d{10}$/; // Exactly 10 digits
            if (!mobilePattern.test(mobileNo)) {
                alert("Mobile number must be exactly 10 digits.");
                return false;
            }
 
            // Validate date of birth
            const dob = new Date(document.forms["managerForm"]["dateOfBirth"].value);
            const age = new Date().getFullYear() - dob.getFullYear();
            if (age < 18 || (age === 18 && new Date() < new Date(dob.setFullYear(dob.getFullYear() + 18)))) {
                alert("You must be at least 18 years old.");
                return false;
            }
            
            // Validate names
            const firstName = document.forms["managerForm"]["firstName"].value;
            const lastName = document.forms["managerForm"]["lastName"].value;
            const namePattern = /^[A-Za-z]{4,}$/;
            if (!namePattern.test(firstName)) {
                alert("First name must be more than 3 alphabetic characters.");
                return false;
            }
            if (!namePattern.test(lastName)) {
                alert("Last name must be more than 3 alphabetic characters.");
                return false;
            }
            
            
            
            // Validate password
            const password = document.forms["managerForm"]["password"].value;
            const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@!$%^&*]{6,10}$/; // Allow special characters
            if (!passwordPattern.test(password)) {
                alert("Password must be 6 to 10 characters long and include at least one uppercase letter, one lowercase letter, and one number.");
                return false;
            }
 
            // Ensure all fields are filled
            const fields = ["firstName", "lastName", "emailId", "mobileNo", "dateOfBirth", "experience", "username", "password", "profileImage", "idProof", "resume"];
            for (let field of fields) {
                if (document.forms["managerForm"][field].value === "") {
                    alert("All fields are mandatory.");
                    return false;
                }
            }
 
            return true; // If all validations pass
        }
        function togglePassword() {
            const passwordField = document.getElementById("password"); // Make sure this matches the HTML id
            const showPasswordCheckbox = document.getElementById("showPassword");
            
            if (showPasswordCheckbox.checked) {
                passwordField.type = "text"; // Show password
            } else {
                passwordField.type = "password"; // Hide password
            }
        }
    </script>
 
</head>
<body
	style="background-image: url('https://img.freepik.com/premium-photo/flat-lay-home-office-desk-female-workspace-with-note-book-eyeglasses-tea-mug-diary-plant-copy-space_151851-524.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
 
	<%@include file="header.jsp"%>
 
	<div class="content">
		<form name="managerForm" action="managerRegister" method="post"
			enctype="multipart/form-data" onsubmit="return validateForm()">
			<center>
				<h2>Manager Registration</h2>
			</center>
 
			<input type="text" name="firstName" placeholder="Enter First Name"
				required /><br /> <input type="text" name="lastName"
				placeholder="Enter Last Name" required /><br /> <input type="text"
				name="emailId" placeholder="Enter Email Id" required /><br /> <input
				type="text" name="mobileNo" placeholder="Enter Mobile No" required /><br />
			<input type="date" name="dateOfBirth" required /><br /> <input
				type="number" name="experience"
				placeholder="Enter experience as a manager" min="0" max="50"
				step="1" value="0" required /> <input type="text" name="username"
				placeholder="Enter username" required /><br /> <input
				type="password" id="password" name="password"
				placeholder="Enter password" required /> <input type="checkbox"
				id="showPassword" onclick="togglePassword()"> Show Password<br />
 
 
 
			<p>Upload Profile Image</p>
			<input type="file" name="profileImage"
				accept=".jpg, .jpeg, .png, .pdf" required>
 
			<p>Upload Id Proof</p>
			<input type="file" name="idProof" accept=".jpg, .jpeg, .png, .pdf"
				required>
 
			<p>Upload Your Latest Resume</p>
			<input type="file" name="resume" accept=".jpg, .jpeg, .png, .pdf"
				required> <input type="submit" value="Submit" />
 
			<p>
				Already Registered? Click <a href="/user/openLoginPage">here</a> to
				login
			</p>
			<p>
				Want to register as Tenant? Click <a
					href="/user/openTenantRegistrationPage">here</a>
			</p>
 
			<%@include file="./message.jsp"%>
		</form>
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
 
 
 