package property_management.app.dao;

import property_management.app.entities.MaintenanceRequest;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import org.springframework.stereotype.Repository;

import java.sql.ResultSet;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

import org.springframework.jdbc.core.RowMapper;

@Repository

public class MaintenanceRequestDaoImpl implements MaintenanceRequestDao {

	private final JdbcTemplate jdbcTemplate;

	public MaintenanceRequestDaoImpl(JdbcTemplate jdbcTemplate) {

		this.jdbcTemplate = jdbcTemplate;

	}

	@Override
	public Optional<Integer> findManagerIdByUserId(Integer userId) {
		String sql = "SELECT manager_id FROM managers WHERE user_id = ?";

		try {
			Integer managerId = jdbcTemplate.queryForObject(sql, new Object[] { userId }, Integer.class);
			return Optional.of(managerId);
		} catch (EmptyResultDataAccessException ex) {
			return Optional.empty();
		}
	}

	@Override
	public List<MaintenanceRequest> getAllRequests() {
		String sql = "SELECT * FROM maintenance_request";
		return jdbcTemplate.query(sql, new MaintenanceRequestRowMapper());
	}

	@Override
	public List<MaintenanceRequest> getAssignedRequests(int managerId) {
		String sql = "SELECT * FROM maintenance_request WHERE manager_id = ?";
		return jdbcTemplate.query(sql, new MaintenanceRequestRowMapper(), managerId);
	}

	private static class MaintenanceRequestRowMapper implements RowMapper<MaintenanceRequest> {
		@Override
		public MaintenanceRequest mapRow(ResultSet rs, int rowNum) throws SQLException {
			MaintenanceRequest request = new MaintenanceRequest();
			request.setMaintenanceId(rs.getInt("maintenance_id"));
			request.setRequestType(rs.getString("request_type"));
			request.setDescription(rs.getString("description"));
			request.setPhoto(rs.getBytes("photo"));
			request.setStatus(rs.getString("status"));
			Timestamp timestamp = rs.getTimestamp("requested_date");
			 if (timestamp != null) {
				 request.setRequestedDate(timestamp.toLocalDateTime());
		        }
			request.setUserId(rs.getInt("user_id"));
			request.setManagerId(rs.getInt("manager_id"));
			request.setTenantId(rs.getInt("tenant_id"));
			request.setFinalCost(rs.getBigDecimal("final_cost"));
			return request;
		}
	}
	
	@Override
	public void saveRequest(MaintenanceRequest request) throws SQLException {

		String sql = "INSERT INTO maintenance_request " + "(request_type, description, photo) " +

				"VALUES (?, ?, ?)";

		// Using JdbcTemplate to execute the insert

		try {

			jdbcTemplate.update(sql,

					request.getRequestType(),

					request.getDescription(),

					request.getPhoto() // Assuming photo is of type byte[]

			);

		} catch (Exception e) {

			// Handle any exceptions that may occur

			throw new SQLException("Error saving maintenance request: " + e.getMessage(), e);

		}

	}

	@Override
	public void updateMaintenanceStatus(int maintenanceId, String status) {
		String sql = "UPDATE maintenance_request SET status = ? WHERE maintenance_id = ?";
		jdbcTemplate.update(sql, status, maintenanceId);
		
	}



}
