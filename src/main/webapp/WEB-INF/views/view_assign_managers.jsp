  
  <%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="property_management.app.entities.Property"%>
<%@ page import="java.util.List"%>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assigned Managers</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table-container {
            margin-top: 30px;
        }
        .container{
        	margin-top: 80px;
        }
    </style>
</head>
<body>
	<%@include file="header.jsp"%>
 
 
<div class="container table-container">
    <h2 class="text-center">Assigned Managers</h2>
    <table class="table table-bordered table-striped">
        <thead class="thead-light">
            <tr>
                <th>Property ID</th>
                <th>Title</th>
                <th>Manager ID</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Property> viewListOfAssingManagers = (List<Property>) request.getAttribute("viewListOfAssingManagers");
                if (viewListOfAssingManagers != null) {
                    for (Property property : viewListOfAssingManagers) {
            %>
                <tr>
                    <td><%= property.getPropertyId() %></td>
                    <td><%= property.getTitle() %></td>
                    <td><%= property.getManagerId() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="3" class="text-center">No assigned managers found.</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
 
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
 
 
 