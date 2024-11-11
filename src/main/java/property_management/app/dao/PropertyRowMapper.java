package property_management.app.dao;

import org.springframework.jdbc.core.RowMapper;

import property_management.app.entities.Property;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PropertyRowMapper implements RowMapper<Property> {
	  @Override
	    public Property mapRow(ResultSet rs, int rowNum) throws SQLException {
	        Property property = new Property();
	        property.setPropertyId(rs.getInt("property_id"));
	        property.setTitle(rs.getString("title"));
	        property.setDescription(rs.getString("description"));
	        property.setPrice(rs.getDouble("price"));
	        property.setpropertyImage(rs.getBytes("image")); // Assuming you store images as BLOB
	        property.setLocation(rs.getString("city"));
	        property.setType(rs.getString("type")); // Assuming you have this field
	        property.setSwimmingPool(rs.getBoolean("swimming_pool")); // Map other facilities as necessary
	        property.setGym(rs.getBoolean("gym"));
	        property.setParking(rs.getBoolean("parking"));
	        property.setGarden(rs.getBoolean("garden"));
	        property.setAirConditioning(rs.getBoolean("air_conditioning"));
	        property.setElevator(rs.getBoolean("elevator"));
	        property.setSecuritySystem(rs.getBoolean("security_system"));
	        property.setInternet(rs.getBoolean("internet"));
	        property.setFurnished(rs.getBoolean("furnished"));
	        property.setStatus(rs.getString("status"));
	        
	        return property;
	    }
}
