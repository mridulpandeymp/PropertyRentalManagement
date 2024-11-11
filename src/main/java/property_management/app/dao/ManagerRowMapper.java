package property_management.app.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import property_management.app.entities.Manager;

public class ManagerRowMapper implements RowMapper<Manager> {

	public Manager mapRow(ResultSet rs, int rowNum) throws SQLException {
		Manager manager = new Manager();
		manager.setManagerId(rs.getInt("manager_id"));

		manager.setExperience_years(rs.getInt("experience_years"));
		manager.setApproved(rs.getBoolean("status"));
		manager.setName(rs.getString("first_name"));
		manager.setMobileNo(rs.getString("mobile_no"));
		manager.setUserId(rs.getInt("user_id"));
		return manager;

	}

}
