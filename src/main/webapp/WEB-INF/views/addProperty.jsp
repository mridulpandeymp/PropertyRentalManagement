<%-- <%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Registration Page</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>


	<h2>Add Property</h2>




	<form:form method="POST"
		action="${pageContext.request.contextPath}/property/addProperty"
		modelAttribute="property" enctype="multipart/form-data">

		<table>
			<tr>
				<td>Property Title:</td>
				<td><form:input path="title" /></td>
			</tr>
			<tr>
				<td>Property Description:</td>
				<td><form:input path="description" /></td>
			</tr>
			<tr>
				<td>Property Type:</td>
				<td><form:select path="type_id">
						<form:option value="1">Villa</form:option>
						<form:option value="2">Apartment</form:option>
						<form:option value="3">Town House</form:option>
					</form:select></td>
			</tr>
			<tr>
				<td>Price:</td>
				<td><form:input path="price" type="number" step="100" /></td>
				<td><form:input path="status" value="active" type="hidden"/></td>
			</tr>
				
			<tr>
				<td>Flat Number:</td>
				<td><form:input path="flatNo" /></td>
			</tr>
			<tr>
				<td>Floor:</td>
				<td><form:input path="floor" /></td>
			</tr>
			<tr>
				<td>Address:</td>
				<td><form:input path="address" /></td>
			</tr>
			<tr>
				<td>City:</td>
				<td><form:input path="city" /></td>
			</tr>
			<tr>
				<td>State:</td>
				<td><form:input path="state" /></td>
			</tr>
			<tr>
				<td>Zip Code:</td>
				<td><form:input path="zip_code" /></td>
			</tr>

			<!-- Facilities -->
			<tr>
				<td>Swimming Pool:</td>
				<td><form:checkbox path="swimmingPool" /></td>
			</tr>
			<tr>
				<td>Gym:</td>
				<td><form:checkbox path="gym" /></td>
			</tr>
			<tr>
				<td>Parking:</td>
				<td><form:checkbox path="parking" /></td>
			</tr>
			<tr>
				<td>Garden:</td>
				<td><form:checkbox path="garden" /></td>
			</tr>
			<tr>
				<td>Air Conditioning:</td>
				<td><form:checkbox path="airConditioning" /></td>
			</tr>
			<tr>
				<td>Elevator:</td>
				<td><form:checkbox path="elevator" /></td>
			</tr>
			<tr>
				<td>Security System:</td>
				<td><form:checkbox path="securitySystem" /></td>
			</tr>
			<tr>
				<td>Internet:</td>
				<td><form:checkbox path="internet" /></td>
			</tr>
			<tr>
				<td>Furnished:</td>
				<td><form:checkbox path="furnished" /></td>
			</tr>

			<!-- Image Upload -->
			<tr>
				<td>Property Image:</td>
				<td><input type="file" name="image" id="image" /></td>

			</tr>

		</table>

		<button type="submit">Add Property</button>

	</form:form>
</body>
</html> --%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Registration Page</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestyle.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   </head>
 
<style>
	* {
    box-sizing: border-box; /* Ensure padding and borders are included in the element's total width and height */
    margin: 0;
    padding: 0;
}
 
body {
    display: flex;
    flex-direction: column; /* Stack elements vertically */
    min-height: 100vh; /* Full height for the body */
    font-family: 'Arial', sans-serif; /* Font for the entire page */
    background-color: #f4f4f4; /* Light background color for contrast */
}
 
.content {
    flex: 1; /* Allow the content to take up remaining space */
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    margin-top: 80px;
}
 
form {
    background: white; /* White background for form */
    border-radius: 10px; /* Rounded corners */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2); /* Shadow for depth */
    padding: 20px; /* Padding inside form */
    width: 100%; /* Full width */
    max-width: 600px; /* Maximum width */
}
 
h2 {
    margin-bottom: 20px;
    color: #333; /* Darker text for headings */
    text-align: center; /* Center the title */
}
 
table {
    width: 100%; /* Full width for table */
    border-collapse: collapse; /* Collapse borders for cleaner look */
}
 
td {
    padding: 10px; /* Padding inside table cells */
}
 
input[type="text"],
input[type="number"],
select {
    width: 100%; /* Full width */
    padding: 10px; /* Padding for inputs */
    border: 1px solid #ccc; /* Border color */
    border-radius: 5px; /* Rounded corners */
    font-size: 16px; /* Font size */
    transition: border 0.3s; /* Transition for border color on focus */
}
 
input[type="text"]:focus,
input[type="number"]:focus,
select:focus {
    border-color: #4CAF50; /* Change border color on focus */
    outline: none; /* Remove outline */
}
 
input[type="checkbox"] {
    transform: scale(1.5); /* Increase size of checkboxes */
    margin-left: 10px; /* Space to the left of checkbox */
}
 
button[type="submit"] {
    background-color: #4CAF50; /* Green background */
    color: white; /* White text */
    border: none; /* No border */
    border-radius: 5px; /* Rounded corners */
    padding: 10px 15px; /* Padding */
    font-size: 16px; /* Font size */
    cursor: pointer; /* Pointer on hover */
    width: 100%; /* Full width */
    margin-top: 20px; /* Space above button */
    transition: background-color 0.3s; /* Transition for hover effect */
}
 
button[type="submit"]:hover {
    background-color: #45a049; /* Darker green on hover */
}
 
 
	
</style>
<body>
 
<%@include file="header.jsp" %>
 
 
<div>
<div class="content">
 
 
	<form:form method="POST"
		action="${pageContext.request.contextPath}/property/addProperty"
		modelAttribute="property" enctype="multipart/form-data">
	<h2>Add Property</h2>
 
		<table>
			<tr>
				<td>Property Title:</td>
				<td><form:input path="title" /></td>
			</tr>
			<tr>
				<td>Property Description:</td>
				<td><form:input path="description" /></td>
			</tr>
			<tr>
				<td>Property Type:</td>
				<td><form:select path="type_id">
						<form:option value="1">Villa</form:option>
						<form:option value="2">Apartment</form:option>
						<form:option value="3">Town House</form:option>
					</form:select></td>
			</tr>
			<tr>
				<td>Price:</td>
				<td><form:input path="price" type="number" step="100" /></td>
				<td><form:input path="status" value="active" type="hidden"/></td>
			</tr>
			<tr>
				<td>Flat Number:</td>
				<td><form:input path="flatNo" /></td>
			</tr>
			<tr>
				<td>Floor:</td>
				<td><form:input path="floor" /></td>
			</tr>
			<tr>
				<td>Address:</td>
				<td><form:input path="address" /></td>
			</tr>
			<tr>
				<td>City:</td>
				<td><form:input path="city" /></td>
			</tr>
			<tr>
				<td>State:</td>
				<td><form:input path="state" /></td>
			</tr>
			<tr>
				<td>Zip Code:</td>
				<td><form:input path="zip_code" /></td>
			</tr>
 
			<!-- Facilities -->
			<tr>
				<td>Swimming Pool:</td>
				<td><form:checkbox path="swimmingPool" /></td>
			</tr>
			<tr>
				<td>Gym:</td>
				<td><form:checkbox path="gym" /></td>
			</tr>
			<tr>
				<td>Parking:</td>
				<td><form:checkbox path="parking" /></td>
			</tr>
			<tr>
				<td>Garden:</td>
				<td><form:checkbox path="garden" /></td>
			</tr>
			<tr>
				<td>Air Conditioning:</td>
				<td><form:checkbox path="airConditioning" /></td>
			</tr>
			<tr>
				<td>Elevator:</td>
				<td><form:checkbox path="elevator" /></td>
			</tr>
			<tr>
				<td>Security System:</td>
				<td><form:checkbox path="securitySystem" /></td>
			</tr>
			<tr>
				<td>Internet:</td>
				<td><form:checkbox path="internet" /></td>
			</tr>
			<tr>
				<td>Furnished:</td>
				<td><form:checkbox path="furnished" /></td>
			</tr>
 
			<!-- Image Upload -->
			<tr>
				<td>Property Image:</td>
				<td><input type="file" name="image" id="image" /></td>
 
			</tr>
 
		</table>
 
		<button type="submit">Add Property</button>
 
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
</div>
 
</body>
</html>
 