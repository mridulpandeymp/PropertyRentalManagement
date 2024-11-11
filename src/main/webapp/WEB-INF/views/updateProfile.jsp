<%-- <%@page import="property_management.app.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<title>Update Profile</title>
<link href="../css/styles.css" rel="stylesheet" />
</head>
<body>
	<h1>Profile</h1>

	<form:form method="POST" action="/user/update" modelAttribute="user"
		enctype="multipart/form-data">
		<table>
			<form:hidden path="userId" />
			<tr>
				<td>First Name:</td>
				<td><form:input path="firstName" /></td>
			</tr>
			<tr>
				<td>Last Name:</td>
				<td><form:input path="lastName" /></td>
			</tr>
			<tr>
				<td>Email ID:</td>
				<td><form:input path="emailId" /></td>
			</tr>
			<tr>
				<td>Mobile No:</td>
				<td><form:input path="mobileNo" /></td>
			</tr>
			<tr>
				<td>Date of Birth:</td>
				<td><form:input path="dateOfBirth" type="date" /></td>
			</tr>
			<tr>
				<td>Username:</td>
				<td><form:input path="username" /></td>
			</tr>
			<tr>
				<td>Status:</td>
				<td><form:input path="status" /></td>
			</tr>
			<tr>
				<td>Profile Image:</td>
				<td>
					<%
					String profileImage = (String) session.getAttribute("profileImage");
					%> <%
 if (profileImage != null && !profileImage.isEmpty()) {
 %> <img src="data:image/jpeg;base64,<%=profileImage%>"
					alt="Profile Image" id="profileImagePreview" /> <%
 } else {
 %>
					<p>No Profile Image</p> <%
 }
 %> <input type="file" name="profileImage"
					id="profileImage" onchange="previewImage(event)">
				</td>
			</tr>
			<tr>
				<td>Id Proof:</td>
				<td>
					<%
					String idProof = (String) session.getAttribute("idProof");
					%> <%
 if (idProof != null && !idProof.isEmpty()) {
 %> <img src="data:image/jpeg;base64,<%=idProof%>" alt="ID Proof"
					id="idProofPreview" /> <%
 } else {
 %>
					<p>No ID Proof</p> <%
 }
 %> <input type="file" name="idProof"
					id="idProof" onchange="previewIdProof(event)">
				</td>
			</tr>
		</table>
		<br>
		<button type="submit">Save Changes</button>
	</form:form>

	<script>
		// JavaScript to preview the image
		function previewImage(event) {
			var reader = new FileReader();
			reader.onload = function() {
				var output = document.getElementById('profileImagePreview');
				output.src = reader.result;
			}
			reader.readAsDataURL(event.target.files[0]);
		}

		function previewIdProof(event) {
			var reader = new FileReader();
			reader.onload = function() {
				var output = document.getElementById('idProofPreview');
				output.src = reader.result;
			}
			reader.readAsDataURL(event.target.files[0]);
		}
	</script>



</body>
</html>
 --%>


<%-- <%@page import="property_management.app.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
 
<html>
<head>
    <title>Update Profile</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestyle.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5; /* Light gray background */
            color: #333; /* Dark gray text */
        }
 
        .content {
            margin: 80px auto; /* Space for header */
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
            border-radius: 12px; /* Rounded corners */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            max-width: 800px; /* Limit content width */
            margin-bottom: 60px; /* Space for footer */
        }
 
        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 2.5em; /* Large heading */
            color: #007bff; /* Blue color */
        }
 
        table {
            width: 100%;
            border-collapse: collapse; /* Remove spacing between cells */
            margin-top: 20px;
        }
 
        td {
            padding: 12px; /* Padding for table cells */
            border-bottom: 1px solid #ccc; /* Light border for separation */
        }
 
        td:first-child {
            font-weight: bold; /* Bold for labels */
            color: #555; /* Darker gray for labels */
        }
 
        img {
            max-width: 100px; /* Limit the image size */
            height: auto; /* Maintain aspect ratio */
            border-radius: 8px; /* Rounded corners for images */
        }
 
        button {
            display: block;
            width: 200px; /* Fixed width for button */
            padding: 10px;
            margin: 20px auto; /* Center the button */
            border: none;
            border-radius: 8px; /* Rounded corners */
            background-color: #28a745; /* Green button */
            color: white;
            font-weight: bold; /* Bold text */
            cursor: pointer;
            transition: background-color 0.3s ease; /* Smooth transition */
        }
 
        button:hover {
            background-color: #218838; /* Darker green on hover */
        }
 
        /* Footer styles */
        .footer {
            background-color: #007bff; /* Blue background */
            color: white;
            padding: 20px 0;
            text-align: center;
            position: relative;
            bottom: 0;
            width: 100%;
        }
 
        .footer-content {
            max-width: 800px;
            margin: auto;
        }
 
        .footer-left {
            float: left;
            text-align: left;
        }
 
        .footer-right {
            float: right;
            text-align: right;
        }
 
        .footer-bottom {
            clear: both;
            padding-top: 10px;
        }
 
        .social-icons {
            list-style: none;
            padding: 0;
        }
 
        .social-icons li {
            display: inline;
            margin: 0 10px;
        }
 
        .social-icons a {
            color: white;
            text-decoration: none;
        }
 
    </style>
</head>
<body>
 
<%@include file="header.jsp" %>
 
<div class="content">
    <h1>Update Profile</h1>
 
    <form:form method="POST" action="/user/update" modelAttribute="user" enctype="multipart/form-data">
        <table>
            <form:hidden path="userId" />
            <tr>
                <td>First Name:</td>
                <td><form:input path="firstName" /></td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td><form:input path="lastName" /></td>
            </tr>
            <tr>
                <td>Email ID:</td>
                <td><form:input path="emailId" /></td>
            </tr>
            <tr>
                <td>Mobile No:</td>
                <td><form:input path="mobileNo" /></td>
            </tr>
            <tr>
                <td>Date of Birth:</td>
                <td><form:input path="dateOfBirth" type="date" /></td>
            </tr>
            <tr>
                <td>Username:</td>
                <td><form:input path="username" /></td>
            </tr>
           
            <tr>
                <td>Profile Image:</td>
                <td>
                    <%
                    String profileImage = (String) session.getAttribute("profileImage");
                    %>
                    <%
                    if (profileImage != null && !profileImage.isEmpty()) {
                    %>
                        <img src="data:image/jpeg;base64,<%=profileImage%>" alt="Profile Image" id="profileImagePreview" />
                    <%
                    } else {
                    %>
                        <p>No Profile Image</p>
                    <%
                    }
                    %>
                    <input type="file" name="profileImage" id="profileImage" onchange="previewImage(event)">
                </td>
            </tr>
            <tr>
                <td>ID Proof:</td>
                <td>
                    <%
                    String idProof = (String) session.getAttribute("idProof");
                    %>
                    <%
                    if (idProof != null && !idProof.isEmpty()) {
                    %>
                        <img src="data:image/jpeg;base64,<%=idProof%>" alt="ID Proof" id="idProofPreview" />
                    <%
                    } else {
                    %>
                        <p>No ID Proof</p>
                    <%
                    }
                    %>
                    <input type="file" name="idProof" id="idProof" onchange="previewIdProof(event)">
                </td>
            </tr>
        </table>
        <br>
        <button type="submit">Save Changes</button>
    </form:form>
 
    <script>
        // JavaScript to preview the image
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function() {
                var output = document.getElementById('profileImagePreview');
                output.src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
        }
 
        function previewIdProof(event) {
            var reader = new FileReader();
            reader.onload = function() {
                var output = document.getElementById('idProofPreview');
                output.src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
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
 
  --%>



<%@page import="property_management.app.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<title>Update Profile</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f5f5f5; /* Light gray background */
	color: #333; /* Dark gray text */
}

.content {
	margin: 80px auto; /* Space for header */
	padding: 20px;
	background-color: rgba(255, 255, 255, 0.9);
	/* Semi-transparent white background */
	border-radius: 12px; /* Rounded corners */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Subtle shadow */
	max-width: 800px; /* Limit content width */
	margin-bottom: 60px; /* Space for footer */
}

h1 {
	text-align: center;
	margin-bottom: 20px;
	font-size: 2.5em; /* Large heading */
	color: #007bff; /* Blue color */
}

table {
	width: 100%;
	border-collapse: collapse; /* Remove spacing between cells */
	margin-top: 20px;
}

td {
	padding: 12px; /* Padding for table cells */
	border-bottom: 1px solid #ccc; /* Light border for separation */
}

td:first-child {
	font-weight: bold; /* Bold for labels */
	color: #555; /* Darker gray for labels */
}

img {
	max-width: 100px; /* Limit the image size */
	height: auto; /* Maintain aspect ratio */
	border-radius: 8px; /* Rounded corners for images */
}

button {
	display: block;
	width: 200px; /* Fixed width for button */
	padding: 10px;
	margin: 20px auto; /* Center the button */
	border: none;
	border-radius: 8px; /* Rounded corners */
	background-color: #28a745; /* Green button */
	color: white;
	font-weight: bold; /* Bold text */
	cursor: pointer;
	transition: background-color 0.3s ease; /* Smooth transition */
}

button:hover {
	background-color: #218838; /* Darker green on hover */
}

/* Footer styles */
.footer {
	background-color: #007bff; /* Blue background */
	color: white;
	padding: 20px 0;
	text-align: center;
	position: relative;
	bottom: 0;
	width: 100%;
}

.footer-content {
	max-width: 800px;
	margin: auto;
}

.footer-left {
	float: left;
	text-align: left;
}

.footer-right {
	float: right;
	text-align: right;
}

.footer-bottom {
	clear: both;
	padding-top: 10px;
}

.social-icons {
	list-style: none;
	padding: 0;
}

.social-icons li {
	display: inline;
	margin: 0 10px;
}

.social-icons a {
	color: white;
	text-decoration: none;
}
</style>

<script>
    function validateForm() {
        // Access the form directly
        const form = document.forms[0]; // or use document.forms["managerForm"]
        
        // Validate names
        const firstName = form["firstName"].value; // Access first name
        const lastName = form["lastName"].value; // Access last name
        const namePattern = /^[A-Za-z]{4,}$/; // Name must be at least 4 alphabetic characters
        if (!namePattern.test(firstName)) {
            alert("First name must be more than 3 alphabetic characters.");
            return false;
        }
        if (!namePattern.test(lastName)) {
            alert("Last name must be more than 3 alphabetic characters.");
            return false;
        }
        
        
 
        // Validate email
        const email = form["emailId"].value; // Access the email field
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            alert("Please enter a valid email address.");
            return false;
        }
 
        const mobileNo = form["mobileNo"].value; // Access mobile number
        const mobilePattern = /^\d{10}$/; // Exactly 10 digits
        if (!mobilePattern.test(mobileNo)) {
            alert("Mobile number must be exactly 10 digits.");
            return false;
        }
 
        // Validate date of birth
        const dob = new Date(form["dateOfBirth"].value); // Access DOB
        const age = new Date().getFullYear() - dob.getFullYear();
        if (age < 18 || (age === 18 && new Date() < new Date(dob.setFullYear(dob.getFullYear() + 18)))) {
            alert("You must be at least 18 years old.");
            return false;
        }
 
      
 
        // Validate password
        const password = form["password"].value; // Access password
        const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@!$%^&*]{6,10}$/; // Allow special characters
        if (!passwordPattern.test(password)) {
            alert("Password must be 6 to 10 characters long and include at least one uppercase letter, one lowercase letter, and one number.");
            return false;
        }
 
        // Ensure all fields are filled
        const fields = ["firstName", "lastName", "emailId", "mobileNo", "dateOfBirth", "experience", "username", "password", "profileImage", "idProof", "resume"];
        for (let field of fields) {
            if (form[field].value === "") {
                alert("All fields are mandatory.");
                return false;
            }
        }
 
        return true; // If all validations pass
    }
    function previewImage(event) {
        var reader = new FileReader();
        reader.onload = function() {
            var output = document.getElementById('profileImagePreview');
            output.src = reader.result;
        }
        reader.readAsDataURL(event.target.files[0]);
    }
 
    function previewIdProof(event) {
        var reader = new FileReader();
        reader.onload = function() {
            var output = document.getElementById('idProofPreview');
            output.src = reader.result;
        }
        reader.readAsDataURL(event.target.files[0]);
    }
 
    </script>
</head>
<body>

	<%@include file="header.jsp"%>

	<div class="content">
		<h1>Update Profile</h1>

		<form:form method="POST" action="/user/update" modelAttribute="user"
			enctype="multipart/form-data" onsubmit="return validateForm()">
			<table>
				<form:hidden path="userId" />
				<tr>
					<td>First Name:</td>
					<td><form:input path="firstName" /></td>
				</tr>
				<tr>
					<td>Last Name:</td>
					<td><form:input path="lastName" /></td>
				</tr>
				<tr>
					<td>Email ID:</td>
					<td><form:input path="emailId" /></td>
				</tr>
				<tr>
					<td>Mobile No:</td>
					<td><form:input path="mobileNo" /></td>
				</tr>
				<tr>
					<td>Date of Birth:</td>
					<td><form:input path="dateOfBirth" type="date" /></td>
				</tr>
				<tr>
					<td>Username:</td>
					<td><form:input path="username" required="required" /></td>
					<td><form:input path="status" hidden="hidden" /></td>
				</tr>




				<tr>
					<td>Profile Image:</td>
					<td>
						<%
						String profileImage = (String) session.getAttribute("profileImage");
						%> <%
 if (profileImage != null && !profileImage.isEmpty()) {
 %> <img src="data:image/jpeg;base64,<%=profileImage%>"
						alt="Profile Image" id="profileImagePreview" /> <%
 } else {
 %>
						<p>No Profile Image</p> <%
 }
 %> <input type="file" name="profileImage" id="profileImage"
						onchange="previewImage(event)">
					</td>
				</tr>
				<tr>
					<td>ID Proof:</td>
					<td>
						<%
						String idProof = (String) session.getAttribute("idProof");
						%> <%
 if (idProof != null && !idProof.isEmpty()) {
 %> <img src="data:image/jpeg;base64,<%=idProof%>" alt="ID Proof"
						id="idProofPreview" /> <%
 } else {
 %>
						<p>No ID Proof</p> <%
 }
 %> <input type="file" name="idProof" id="idProof"
						onchange="previewIdProof(event)">
					</td>
				</tr>




			</table>
			<br>
			<button type="submit">Save Changes</button>
		</form:form>


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


