<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="property_management.app.entities.Manager" %>
<%@ page import="property_management.app.entities.Property"%>
<%@ page import="java.util.List"%>
 
<%
    List<Manager> approvedManagers = (List<Manager>) request.getAttribute("approvedManagers");
    List<Property> properties = (List<Property>) request.getAttribute("properties");
    List<Manager> assignedManagers=(List<Manager>)request.getAttribute("assignedManagers");
    
    String message = (String) request.getAttribute("message");
%>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Manager</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	
	<style>
/* General Content Styling */
.content {
    max-width: 1200px;
    margin: 20px auto;
    padding: 20px;
    background-color: rgba(255, 255, 255, 0.4); /* Semi-transparent white */
    border-radius: 10px;
    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
    margin-top: 100px;
}
 
/* Headings */
.content h1 {
    font-size: 2.5rem;
    color: #333;
    text-align: center;
    margin-bottom: 20px;
    font-weight: 700;
    text-transform: uppercase;
}
 
/* Message Styling */
.content div {
    text-align: center;
    margin-bottom: 20px;
    font-size: 1.1rem;
    color: green;
}
 
/* Form Label Styling */
label {
    font-size: 1.2rem;
    margin-bottom: 10px;
    display: block;
    color: #555;
}
 
/* Table Styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}
 
th, td {
    padding: 12px;
    text-align: left;
    border: 1px solid #ddd;
}
 
th {
    background-color: #007BFF; /* Bootstrap primary color */
    color: white;
    font-weight: bold;
}
 
/* Row Hover Effect */
tr:hover {
    background-color: #f1f1f1;
}
 
/* Button Container */
.button-container {
    display: flex;
    justify-content: center; /* Center align buttons */
    gap: 20px; /* Space between buttons */
    margin-top: 20px; /* Space above buttons */
}
 
/* Button Styling */
button {
    background-color: #28a745; /* Green for assign */
    color: white;
    border: none;
    border-radius: 5px;
    padding: 12px 20px;
    font-size: 1rem;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
    margin-bottom: 10px;
}
 
/* Button Hover Effects */
button:hover {
    background-color: #218838; /* Darker green on hover */
    transform: translateY(-2px); /* Lift effect */
}
 
/* Responsive Design */
@media (max-width: 768px) {
    .content {
        padding: 15px;
    }
 
    .content h1 {
        font-size: 2rem;
    }
 
    th, td {
        padding: 10px;
        font-size: 0.9rem;
    }
 
    button {
        padding: 10px 15px;
        font-size: 0.9rem;
    }
 
    label {
        font-size: 1rem;
    }
}
 
		
	</style>
</head>
<body style="background-image: url('https://wallpaperaccess.com/full/1657789.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
	<%@include file="header.jsp"%>
 
	<div>
	<div class="content">
<h1>Assign/Remove Manager to Property</h1>
 
<%
    if (message != null && !message.isEmpty()) {
%>
<div style="color: green;">
    <%= message %>
</div>
<%
    }
%>
 
<form action="<%= request.getContextPath() + "/assignManager" %>" method="POST">
    <label for="managerId">Select Approved Manager:</label>
    
    <table border="1">
        <tr>
            <th>Manager Name</th>
            <th>Manager Mobile No</th>
            <th>Experience (Years)</th>
            <th>Action</th>
        </tr>
        <%
            if (approvedManagers != null && !approvedManagers.isEmpty()) {
                for (Manager manager : approvedManagers) {
        %>
        <tr>
            <td style="cursor: pointer;" onclick="location.href='/managerProfile/<%= manager.getUserId() %>'"><%=manager.getName()%></td>
			<td style="cursor: pointer;" onclick="location.href='/managerProfile/<%= manager.getUserId() %>'"><%=manager.getMobileNo()%></td>
			<td style="cursor: pointer;" onclick="location.href='/managerProfile/<%= manager.getUserId() %>'"><%=manager.getExperience_years()%></td>
            <td>
                <input type="radio" name="managerId" value="<%= manager.getManagerId() %>"/>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="3">No approved managers available</td>
        </tr>
        <%
            }
        %>
    </table>
 
    <label for="propertyId">Select Property:</label>
    <select name="propertyId" id="propertyId">
        <%
            if (properties != null && !properties.isEmpty()) {
                for (Property property : properties) {
        %>
            <option value="<%= property.getPropertyId() %>"><%= property.getTitle() %></option>
        <%
                }
            } else {
        %>
            <option value="">No properties available</option>
        <%
            }
        %>
    </select>
 
    <button type="submit">Assign Manager</button>
</form>

<form action="/viewAssignManagers" method="GET">
    <button type="submit">View Assign Manager</button>
</form>
 
   
 
<form action="/landlord/manageManagers" method="GET">
    <button type="submit">Go to Manage Managers</button>
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
	</div>
 
 
</body>
</html>
 
 
  