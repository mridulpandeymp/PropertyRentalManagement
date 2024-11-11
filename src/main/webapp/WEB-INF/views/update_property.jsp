<%@page import="property_management.app.entities.Property"%>
<%@ page import="java.util.Base64" %>
<%
    Property property = (Property) request.getAttribute("property");
%>

<div class="content">
    <div class="edit-property-details">
        <form action="${pageContext.request.contextPath}/landlord/updateProperty/<%= property.getPropertyId() %>" method="post" enctype="multipart/form-data">
            
            <!-- Property ID (Hidden Field) -->
            <input type="hidden" name="propertyId" value="<%= property.getPropertyId() %>" />

            <!-- Title -->
            <label for="title"><strong>Title:</strong></label>
            <input type="text" name="title" id="title" value="<%= property.getTitle() %>" required />

            <!-- Description -->
            <label for="description"><strong>Description:</strong></label>
            <textarea name="description" id="description" required><%= property.getDescription() %></textarea>

            <!-- Location -->
            <label for="location"><strong>Location:</strong></label>
            <input type="text" name="location" id="location" value="<%= property.getLocation() %>" required />

            <!-- Price -->
            <label for="price"><strong>Price:</strong></label>
            <input type="number" name="price" id="price" value="<%= property.getPrice() %>" required />

            <!-- Facilities -->
            <label><strong>Facilities:</strong></label>
            <div class="facility-options">
                <label><input type="checkbox" name="swimmingPool" <%= property.isSwimmingPool() ? "checked" : "" %> /> Swimming Pool</label>
                <label><input type="checkbox" name="gym" <%= property.isGym() ? "checked" : "" %> /> Gym</label>
                <label><input type="checkbox" name="parking" <%= property.isParking() ? "checked" : "" %> /> Parking</label>
                <label><input type="checkbox" name="garden" <%= property.isGarden() ? "checked" : "" %> /> Garden</label>
                <label><input type="checkbox" name="airConditioning" <%= property.isAirConditioning() ? "checked" : "" %> /> Air Conditioning</label>
                <label><input type="checkbox" name="elevator" <%= property.isElevator() ? "checked" : "" %> /> Elevator</label>
                <label><input type="checkbox" name="securitySystem" <%= property.isSecuritySystem() ? "checked" : "" %> /> Security System</label>
                <label><input type="checkbox" name="internet" <%= property.isInternet() ? "checked" : "" %> /> Internet</label>
                <label><input type="checkbox" name="furnished" <%= property.isFurnished() ? "checked" : "" %> /> Furnished</label>
            </div>

            <!-- Property Image -->
            <label><strong>Property Image:</strong></label>
            <div>
                <% if (property.getPropertyImage() != null && property.getPropertyImage().length > 0) { %>
                    <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(property.getPropertyImage()) %>" alt="<%= property.getTitle() %>" style="max-width: 200px; max-height: 150px;" />
                <% } else { %>
                    <img src="/images/default-image.png" alt="Default Image" style="max-width: 200px; max-height: 150px;" />
                <% } %>
            </div>
            <input type="file" name="propertyImage" />

            <!-- Submit and Cancel Buttons -->
            <div class="button-container" style="display: flex; justify-content: space-between; margin-top: 20px;">
                <button type="submit" class="btn-primary">Save Changes</button>
                <a href="javascript:void(0);" class="btn-back" onclick="window.history.back();">Cancel</a>
            </div>
        </form>
    </div>
</div>

<style>
    .edit-property-details {
        max-width: 600px;
        margin: auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    .edit-property-details label {
        font-weight: bold;
        margin-top: 10px;
        display: block;
    }
    .edit-property-details input[type="text"],
    .edit-property-details input[type="number"],
    .edit-property-details textarea,
    .edit-property-details select {
        width: 100%;
        padding: 8px;
        margin-top: 5px;
    }
    .facility-options label {
        display: inline-block;
        margin-right: 10px;
    }
</style>
