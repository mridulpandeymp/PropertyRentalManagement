<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="property_management.app.entities.Manager"%>
<%@ page import="property_management.app.entities.User"%>
<%@ page import="java.util.List"%>
 
<%
List<Manager> managers = (List<Manager>) request.getAttribute("managers");
%>
 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Managers</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	
	<style type="text/css">
		/* General Content Styling */
.content {
    max-width: 1200px;
    margin: 20px auto;
    padding: 20px;
    background: rgba(255, 255, 255, 0.4); /* Semi-transparent white background */
    border-radius: 10px;
    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
    margin-top: 120px;
    margin-bottom: 60px;
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
    background-color: #000000; /* Bootstrap primary color */
    color: white;
    font-weight: bold;
}
 
/* Row Hover Effect */
tr:hover {
    background-color: #f1f1f1;
}
 
/* Button Container */
td form {
    display: inline-block;
    margin: 0 5px;
}
 
/* Button Styling */
button {
    background-color: #000000; /* Green for approve */
    color: white;
    border: none;
    border-radius: 5px;
    padding: 10px 15px;
    font-size: 1rem;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
}
 
button[type="submit"]:nth-of-type(2) {
    background-color: #dc3545; /* Red for reject */
}
 
/* Button Hover Effects */
button:hover {
    transform: translateY(-2px); /* Lift effect */
    background-color: #218838;
}
 
button[type="submit"]:nth-of-type(2):hover {
    background-color: #c82333; /* Darker red for reject */
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
        padding: 8px 12px;
        font-size: 0.9rem;
    }
}
		
	</style>
</head>
<body style="background-image: url('https://wallpaperaccess.com/full/1657789.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
 
	<%@include file="header.jsp"%>
 
	<div>
	<div class="content">
 
	<h1>Manage Managers</h1>
 
	<%
	String message = (String) request.getAttribute("message");
	if (message != null && !message.isEmpty()) {
	%>
	<div style="color: green;">
		<%=message%>
	</div>
	<%
	}
	%>
 
	<table border="1">
		<tr>
			<th>Manager Name</th>
			<th>Manager Mobile No.</th>
			<th>Experience (Years)</th>
			 <th>Status</th>
			<th>Actions</th>
		</tr>
		<%
		if (managers != null && !managers.isEmpty()) {
 
			for (Manager manager : managers) {
		%>
		<tr>
			<td style="cursor: pointer;" onclick="location.href='/managerProfile/<%= manager.getUserId() %>'"><%=manager.getName()%></td>
			<td style="cursor: pointer;" onclick="location.href='/managerProfile/<%= manager.getUserId() %>'"><%=manager.getMobileNo()%></td>
			<td style="cursor: pointer;" onclick="location.href='/managerProfile/<%= manager.getUserId() %>'"><%=manager.getExperience_years()%></td>
			 <td><%=manager.isApproved() ? "Approved" : "Pending"%></td>
 
 
 
			<td>
				<form action="<%=request.getContextPath() + "/approveManager"%>"
					method="POST" style="display: inline;">
					<input type="hidden" name="managerId"
						value="<%=manager.getManagerId()%>" />
					<button type="submit">Approve</button>
				</form>
 
				<form action="<%=request.getContextPath() + "/rejectManager"%>"
					method="POST" style="display: inline;">
					<input type="hidden" name="managerId"
						value="<%=manager.getManagerId()%>" />
					<button type="submit">Reject</button>
				</form>
			</td>
		</tr>
		<%
		}
 
		} else {
		%>
		<tr>
			<td colspan="4">No managers available at the moment.</td>
		</tr>
		<%
		}
		%>
	</table>
 
	<form action="/landlord/manageManagers" method="get">
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
 
 
 
 