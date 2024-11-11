<%@page import="java.util.Base64"%>
<%@page import="property_management.app.entities.Property"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Property Management</title>
<!-- Linking the CSS file -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css">
<head>
<title>View Properties</title>
</head>
<body>  

<%
    Property property = (Property) request.getAttribute("property");
%>

<% if (property != null) { %>
    <form action="${pageContext.request.contextPath}/property/updateProperty" method="post" enctype="multipart/form-data">
    <input type="hidden" name="property_id" value="${property.propertyId}" />
        <label>Title: </label><input type="text" name="title" value="<%= property.getTitle() %>" /><br/>
        <label>Description: </label><input type="text" name="description" value="<%= property.getDescription() %>" /><br/>
  <label>Location:</label>
    <textarea name="location" required>${property.location}</textarea><br/>
        <label>Price: </label><input type="text" name="price" value="<%= property.getPrice() %>" /><br/>

        <label>Amenities: </label><br/>
        <input type="checkbox" name="swimming_pool" <%= property.isSwimmingPool() ? "checked" : "" %> /> Swimming Pool<br/>
        <input type="checkbox" name="gym" <%= property.isGym() ? "checked" : "" %> /> Gym<br/>
        <input type="checkbox" name="garden" <%= property.isGarden() ? "checked" : "" %> /> Garden<br/>
        <input type="checkbox" name="parking" <%= property.isParking() ? "checked" : "" %> /> Parking<br/>
        <input type="checkbox" name="air_conditioning" <%= property.isAirConditioning() ? "checked" : "" %> /> Air Conditioning<br/>
        <input type="checkbox" name="elevator" <%= property.isElevator() ? "checked" : "" %> /> Elevator<br/>
        <input type="checkbox" name="security_system" <%= property.isSecuritySystem() ? "checked" : "" %> /> Security System<br/>
        <input type="checkbox" name="internet" <%= property.isInternet() ? "checked" : "" %> /> Internet<br/>
        <input type="checkbox" name="furnished" <%= property.isFurnished() ? "checked" : "" %> /> Furnished<br/>
        
         <label>Type:</label>
        <select name="type_id">
          <%--   <option value="1" ${property.type_id == '1' ? 'selected' : ''}>Society</option>
            <option value="2" ${property.type_id == '2' ? 'selected' : ''}>Villas</option>
            <option value="3" ${property.type == '3' ? 'selected' : ''}>Independent House</option> --%>
        </select><br/>

        <label>Status:</label>
        <select name="status">
            <option value="Vacant" ${property.status == 'Vacant' ? 'selected' : ''}>Vacant</option>
            <option value="Occupied" ${property.status == 'Occupied' ? 'selected' : ''}>Occupied</option>
            <option value="Under Maintenance" ${property.status == 'Under Maintenance' ? 'selected' : ''}>Under Maintenance</option>
        </select><br/>

        <label>Current Image:</label><br/>
    <% if (property.getImage() != null) { %>
        <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(property.getImage()) %>" alt="Property Image" width="200" height="200" /><br/>
    <% } else { %>
        <p>No image available.</p>
    <% } %>
    
    <!-- File input for uploading a new image -->
    <label>Upload New Image:</label>
    <input type="file" name="image" /><br/>
    
        <button type="submit">Update</button>
    </form>
<% } else { %>
    <p>Property not found.</p>
<% } %>

</body>
</html>
