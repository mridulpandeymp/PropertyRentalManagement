
  <%@page import="property_management.app.entities.Tenant"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tenant Management</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<style>
		/* General Content Styling */
.content {
    max-width: 1200px;
    margin: 50px auto; /* Adjusted for more space from the top */
    padding: 20px;
    background-color: rgba(255, 255, 255, 0.95); /* Light semi-transparent white */
    border-radius: 10px;
    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
    margin-top: 80px;
}
 
/* Headings */
.content h1 {
    font-size: 2.5rem;
    color: #333;
    text-align: center;
    margin-bottom: 20px;
    font-weight: bold;
    text-transform: uppercase;
}
 
/* Table Styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    font-size: 1rem;
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
 
/* Action Buttons Container */
.action-buttons {
    display: flex;
    align-items: center;
    gap: 10px; /* Space between select and button */
}
 
/* Button Styling */
button {
    background-color: #28a745; /* Green for submit */
    color: white;
    border: none;
    border-radius: 5px;
    padding: 10px 15px;
    font-size: 1rem;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
}
 
/* Button Hover Effects */
button:hover {
    background-color: #218838; /* Darker green on hover */
    transform: translateY(-2px); /* Lift effect */
}
 
/* Status Dropdown Styling */
select {
    padding: 8px;
    border-radius: 5px;
    border: 1px solid #ddd;
    font-size: 1rem;
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
        padding: 8px 10px;
        font-size: 0.9rem;
    }
}
		
	</style>
</head>
<body>
 
	<%@include file="header.jsp"%>
 
 

		
<div>
<div class="content">
 
 <h1>Tenant Management</h1>
    
   <% 
    String message = (String) request.getAttribute("message");
    String status = (String) request.getAttribute("status"); // Retrieve the status
    
    if (status != null) {
%>
    <div class="alert alert-success">
        <%= message %> Tenant is now <%= status %> successfully!
    </div>
<% 
    } 
%>

    
   <table>
    <thead>
        <tr>
            <th>Tenant Name</th>
            <th>Tenant Mobile No.</th>
            <th>Type</th>
            <th>No. of Persons</th>
            <th>Property Title</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            List<Tenant> tenantList = (List<Tenant>) request.getAttribute("tenantList");
            if (tenantList != null) {
                for (Tenant tenant : tenantList) {
        %>
        
            <tr>
                <td style="cursor: pointer;" onclick="location.href='/tenant/tenantProfile/<%= tenant.getUserId() %>'"><%= tenant.getName() %></td>
                <td style="cursor: pointer;" onclick="location.href='/tenant/tenantProfile/<%= tenant.getUserId() %>'"><%= tenant.getMobileNo() %></td>
                <td style="cursor: pointer;" onclick="location.href='/tenant/tenantProfile/<%= tenant.getUserId() %>'"><%= tenant.getTenantType() %></td>
                <td style="cursor: pointer;" onclick="location.href='/tenant/tenantProfile/<%= tenant.getUserId() %>'"><%= tenant.getNoOfPerson() %></td>
                <td style="cursor: pointer;" onclick="location.href='/landlord/PropertyDetails/<%= tenant.getPropertyId() %>'"><%= tenant.getPropertyTittle() %></td>
                <td>
                    <form action="/tenant/updateStatus" method="post">
                        <input type="hidden" name="tenantId" value="<%= tenant.getTenantId() %>">
                        <select name="status">
                            <%
                                // Check the current status of the tenant
                                String currentStatus = tenant.getTenantStatus();
                                // Only show "Pending" if the current status is "pending"
                                if ("pending".equals(currentStatus)) {
                            %>
                                <option value="pending" selected>Pending</option>
                            <%
                                }
                            %>
                            <option value="active" <%= "active".equals(currentStatus) ? "selected" : "" %>>Approve</option>
                            <option value="terminated" <%= "terminated".equals(currentStatus) ? "selected" : "" %>>Terminate</option>
                        </select>
                </td>
                <td>
                    <button type="submit">Submit</button>
                    </form>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="7">No tenants available.</td>
            </tr>
        <%
            }
        %>
    </tbody>
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

 