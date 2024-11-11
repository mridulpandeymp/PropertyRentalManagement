package property_management.app.dao;
 
import org.springframework.jdbc.core.RowMapper;
import property_management.app.entities.Property;
 
import java.sql.ResultSet;
import java.sql.SQLException;
 
public class LimitedPropertyRowMapper implements RowMapper<Property> {
	@Override
	public Property mapRow(ResultSet rs, int rowNum) throws SQLException {
		Property property = new Property();
		property.setPropertyId(rs.getInt("property_id"));
		property.setTitle(rs.getString("title"));
		property.setManagerId(rs.getInt("manager_id"));
		return property;
	}
}
 
 