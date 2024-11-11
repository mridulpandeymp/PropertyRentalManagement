<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tenant Registration Page</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}
 
.content {
	flex: 1;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 20px;
	margin-top: 70px;
}
 
h2 {
	margin-bottom: 20px;
	color: #007bff;
	text-align: center;
}
 
form {
	background-color: rgba(255, 255, 255, 0.9);
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	width: 400px;
	box-sizing: border-box;
}
 
input[type="text"], input[type="password"], input[type="date"], input[type="file"]
	{
	width: 100%;
	padding: 10px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}
 
input[type="submit"] {
	background-color: #28a745;
	color: white;
	padding: 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	width: 100%;
	transition: background-color 0.3s ease;
}
 
input[type="submit"]:hover {
	background-color: #218838;
}
 
p {
	text-align: center;
	margin-top: 20px;
}
 
a {
	color: #007bff;
	text-decoration: none;
}
 
a:hover {
	text-decoration: underline;
}
 
.error {
	color: red;
	font-size: 12px;
}
</style>
</head>
<body>
	<%@include file="header.jsp"%>
 
	<div class="content">
		<form action="/user/tenantRegister" method="post"
			enctype="multipart/form-data" onsubmit="return validateForm()">
			<center>
				<h2>Tenant Registration</h2>
			</center>
 
			<input type="text" id="firstName" name="firstName"
				placeholder="Enter First Name" required /> <span
				id="firstName-error" class="error"></span><br /> <input type="text"
				id="lastName" name="lastName" placeholder="Enter Last Name" required />
			<span id="lastName-error" class="error"></span><br /> <input
				type="text" id="email" name="emailId" placeholder="Enter Email Id"
				required /> <span id="email-error" class="error"></span><br /> <input
				type="text" id="phone" name="mobileNo" placeholder="Enter Mobile No"
				required /> <span id="phone-error" class="error"></span><br /> <input
				type="date" id="dateOfBirth" name="dateOfBirth" required /> <span
				id="dob-error" class="error"></span><br /> <input type="text"
				id="username" name="username" placeholder="Enter Username" required />
			<span id="username-error" class="error"></span><br /> <input
				type="password" id="password" name="password"
				placeholder="Enter Password" required /> <span id="password-error"
				class="error"></span><br />
 
			<p>Upload Profile Image</p>
			<input type="file" name="profileImage"
				accept=".jpg, .jpeg, .png, .pdf" required /><br />
 
			<p>Upload Id Proof</p>
			<input type="file" name="idProof" accept=".jpg, .jpeg, .png, .pdf"
				required /><br /> <input type="submit" value="Register" />
		</form>
	</div>
 
	<script>
    function validateForm() {
        const form = document.forms[0]; // Access the form
 
        // Clear previous error messages
        const errorElements = document.querySelectorAll('.error');
        errorElements.forEach(error => error.textContent = '');
        
        
        // Validate names
        const firstName = form["firstName"].value;
        const lastName = form["lastName"].value;
        const namePattern = /^[A-Za-z]{4,}$/; // At least 4 alphabetic characters
        if (!namePattern.test(firstName)) {
            document.getElementById("firstName-error").textContent = "First name must be more than 3 alphabetic characters.";
            return false;
        }
        if (!namePattern.test(lastName)) {
            document.getElementById("lastName-error").textContent = "Last name must be more than 3 alphabetic characters.";
            return false;
        }
 
        // Validate email
        const email = form["emailId"].value;
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            document.getElementById("email-error").textContent = "Please enter a valid email address.";
            return false;
        }
 
        // Validate mobile number
        const mobileNo = form["mobileNo"].value;
        const mobilePattern = /^\d{10}$/; // Exactly 10 digits
        if (!mobilePattern.test(mobileNo)) {
            document.getElementById("phone-error").textContent = "Mobile number must be exactly 10 digits.";
            return false;
        }
 
        // Validate date of birth
        const dob = new Date(form["dateOfBirth"].value);
        const age = new Date().getFullYear() - dob.getFullYear();
        if (age < 18 || (age === 18 && new Date() < new Date(dob.setFullYear(dob.getFullYear() + 18)))) {
            document.getElementById("dob-error").textContent = "You must be at least 18 years old.";
            return false;
        }
 
       
 
        // Validate username
        const username = form["username"].value;
        if (username.length < 4) {
            document.getElementById("username-error").textContent = "Username must be at least 4 characters long.";
            return false;
        }
 
        // Validate password
        const password = form["password"].value;
        const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@!$%^&*]{6,10}$/; // Criteria for password
        if (!passwordPattern.test(password)) {
            document.getElementById("password-error").textContent = "Password must be 6 to 10 characters long and include at least one uppercase letter, one lowercase letter, and one number.";
            return false;
        }
 
        // Ensure all fields are filled (handled by 'required' attribute, but check anyway)
        const fields = ["firstName", "lastName", "emailId", "mobileNo", "dateOfBirth", "username", "password"];
        for (let field of fields) {
            if (form[field].value === "") {
                document.getElementById(`${field}-error`).textContent = "This field is mandatory.";
                return false;
            }
        }
 
        return true; // If all validations pass
    }
</script>
 
 
</body>
</html>
 
 