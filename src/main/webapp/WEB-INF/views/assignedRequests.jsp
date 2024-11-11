<%-- <%@page import="property_management.app.entities.MaintenanceRequest"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Assigned Maintenance Requests</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .error-message {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

<h1>Assigned Maintenance Requests</h1>

<!-- Error message display -->
<% if (request.getAttribute("errorMessage") != null) { %>
    <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<!-- Table to display maintenance requests -->
<table>
    <tr>
        <th>Maintenance ID</th>
        <th>Request Type</th>
        <th>Description</th>
        <th>Status</th>
        <th>Requested Date</th>
    </tr>

    <!-- Check if there are any maintenance requests -->
    <% 
    List<MaintenanceRequest> requests = (List<MaintenanceRequest>) request.getAttribute("assignedRequests");
    if (requests != null && !requests.isEmpty()) {
        for (MaintenanceRequest req : requests) {
    %>
            <tr>
                <td><%= req.getMaintenanceId() %></td>
                <td><%= req.getRequestType() %></td>
                <td><%= req.getDescription() %></td>
                <td><%= req.getStatus() %></td>
                <td><%= req.getRequestedDate() %></td>
            </tr>
    <% 
        }
    } else { 
    %>
        <!-- If no requests found, show message -->
        <tr>
            <td colspan="5">No assigned maintenance requests found.</td>
        </tr>
    <% } %>
    
</table>


</body>
</html>
 --%>
 
 
 <%@page import="property_management.app.entities.MaintenanceRequest"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Assigned Maintenance Requests</title>
    <link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<style>
    
    <style>
    .content{
    	margin-top: 120px;
    }
     /* General Content Styling */
.content {
    max-width: 1200px;
    margin: 100px auto; /* Space from the top */
    padding: 20px;
    background-color: rgba(255, 255, 255, 0.95); /* Semi-transparent white */
    border-radius: 10px;
    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
    margin-bottom: 160px;
    
}
 
/* Heading Styling */
.content h1 {
    font-size: 2.5rem;
  color: #333;
    text-align: center;
    margin-bottom: 20px;
}
 
/* Error Message Styling */
.error-message {
    color: red;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
}
 
/* Table Styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    font-size: 1rem;
}
 
th, td {
    padding: 12px;
    text-align: left;
    border: 1px solid #ddd;
}
 
/* Header Cell Styling */
th {
    background-color: #007BFF; /* Bootstrap primary color */
    color: white;
    font-weight: bold;
}
 
/* Row Hover Effect */
tr:hover {
    background-color: #f1f1f1; /* Light gray for hover effect */
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
}
 
    </style>
</head>
<body>
	<%@include file="header.jsp"%>
 
<div>
<div class="content">
<h1>Assigned Maintenance Requests</h1>
 
<!-- Error message display -->
<% if (request.getAttribute("errorMessage") != null) { %>
    <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
<% } %>
 
<!-- Table to display maintenance requests -->
<table>
    <tr>
        <th>Maintenance ID</th>
        <th>Request Type</th>
        <th>Description</th>
        <th>Status</th>
        <th>Requested Date</th>
    </tr>
 
    <!-- Check if there are any maintenance requests -->
    <%
    List<MaintenanceRequest> requests = (List<MaintenanceRequest>) request.getAttribute("assignedRequests");
    if (requests != null && !requests.isEmpty()) {
        for (MaintenanceRequest req : requests) {
    %>
            <tr>
                <td><%= req.getMaintenanceId() %></td>
                <td><%= req.getRequestType() %></td>
                <td><%= req.getDescription() %></td>
                <td><%= req.getStatus() %></td>
                <td>22/10/2024</td>
            </tr>
    <%
        }
    } else {
    %>
        <!-- If no requests found, show message -->
        <tr>
            <td colspan="5">No assigned maintenance requests found.</td>
        </tr>
    <% } %>
    
</table>
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

 