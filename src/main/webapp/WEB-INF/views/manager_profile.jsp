
 <%@page import="property_management.app.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
 
<html>
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${managerProfile.firstName} Profile</title>
    
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
        max-height: 200%;
        margin-top: 80px;
        margin-left: 60px;
        margin-right:60px;
        padding: 20px;
        background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
        border-radius: 12px; /* Rounded corners */
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Subtle shadow */
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
	 </style>
	    	</head>
<body>
 
	
 
	<%@include file="header.jsp" %>
	
 
<div class="content">
 <%
                User managerProfile = (User) request.getAttribute("managerProfile");
            %>
 
	<h1>${managerProfile.firstName} Profile</h1>
	<table>
		<tr>
			<td>First Name:</td>
			<td>${managerProfile.firstName}</td>
		</tr>
		<tr>
			<td>Last Name:</td>
			<td>${managerProfile.lastName}</td>
		</tr>
		<tr>
			<td>Email ID:</td>
			<td>${managerProfile.emailId}</td>
		</tr>
		<tr>
			<td>Mobile No:</td>
			<td>${managerProfile.mobileNo}</td>
		</tr>
		<tr>
			<td>Date of Birth:</td>
			<td>${managerProfile.dateOfBirth}</td>
		</tr>
		<tr>
			<td>Username:</td>
			<td>${managerProfile.username}</td>
		</tr>
		
		

		
		<tr>
			<td>Profile Image:</td>
			<td>
				<%
				String profileImage = (String) request.getAttribute("profileImage");
				%>
				<%
				if (profileImage != null && !profileImage.isEmpty()) {
				%> <img
				src="data:image/jpeg;base64,<%=profileImage%>" alt="Profile Image" />
				<%
				} else {
				%>
				<p>No Profile Image</p> <%}%>
			</td>
		</tr>
		<tr>
			<td>ID Proof:</td>
			<td>
				<%
				String idProof = (String) request.getAttribute("idProof");
				%>
				<%
				if (idProof != null && !idProof.isEmpty()) {
				%> <img
				src="data:image/jpeg;base64,<%=idProof%>" alt="Id Proof" />
				<%
				} else {
				%>
				<p>No ID Proof</p> <%}%>
			</td>
		</tr>
	</table>
	<!-- <a href="/approveRejectManagers">
		<button>Go Back</button>
	</a> -->
	
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
 
 
 