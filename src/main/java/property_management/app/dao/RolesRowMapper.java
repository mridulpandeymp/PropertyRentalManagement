package property_management.app.dao;
import property_management.app.entities.Role;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;



public class RolesRowMapper implements RowMapper<Role> {

	@Override
	public Role mapRow(ResultSet rs, int rowNum) throws SQLException {

		int roleId = rs.getInt("role_id");
		String role = rs.getString("role_name");

		return new Role(roleId, role);
	}

}
