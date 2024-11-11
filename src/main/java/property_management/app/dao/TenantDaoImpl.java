package property_management.app.dao;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import property_management.app.entities.Tenant;
import property_management.app.entities.User;

import org.springframework.jdbc.core.RowMapper;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Repository
public class TenantDaoImpl implements TenantDao {

	private final JdbcTemplate jdbcTemplate;

	public TenantDaoImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public List<Tenant> getAssignedTenants(int managerId) {
		String sql = "SELECT t.* FROM tenants t " + "JOIN properties p ON t.property_id = p.property_id "
				+ "WHERE p.manager_id = ?";

		List<Tenant> tenants = jdbcTemplate.query(sql, new TenantRowMapper(), managerId);

		// Log the retrieved tenants to ensure data is being fetched
		System.out.println("Tenants assigned to manager: " + tenants);

		return tenants;
	}

	@Override
	public Tenant getTenantByUserId(int userId) {
		try {
			return jdbcTemplate.queryForObject("SELECT * FROM tenants WHERE user_id = ?", new Object[] { userId },
					new BeanPropertyRowMapper<>(Tenant.class));
		} catch (EmptyResultDataAccessException e) {
			return null; // Handle the case where no tenant is found
		}
	}

	@Override
	public List<Tenant> getAllTenants() {
		String sql = "SELECT t.*, u.first_name, u.mobile_no, p.title AS property_title " + "FROM tenants t "
				+ "JOIN user u ON t.user_id = u.user_id " + "JOIN property p ON t.property_id = p.property_id";
		return jdbcTemplate.query(sql, new TenantRowMapper());
	}

	@Override
	public void saveTenant(Tenant tenant) {
		String sql = "INSERT INTO tenants (tenant_type, no_of_person, tenant_status, created_at, updated_at, property_id, user_id) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, tenant.getTenantType(), tenant.getNoOfPerson(), tenant.getTenantStatus(),
				tenant.getCreatedAt(), tenant.getUpdatedAt(), tenant.getPropertyId(), tenant.getUserId());
	}

	@Override
	public void updateTenant(Tenant tenant) {
		String sql = "UPDATE tenants SET tenant_type = ?, no_of_person = ?, tenant_status = ?, updated_at = ?, property_id = ? WHERE tenant_id = ?";
		jdbcTemplate.update(sql, tenant.getTenantType(), tenant.getNoOfPerson(), tenant.getTenantStatus(),
				tenant.getUpdatedAt(), tenant.getPropertyId(), tenant.getTenantId());
	}

	@Override
	public void deleteTenant(int tenantId) {
		String sql = "DELETE FROM tenants WHERE tenant_id = ?";
		jdbcTemplate.update(sql, tenantId);
	}

	@Override
	public void assignTenantToProperty(int tenantId, int propertyId) {
		String sql = "INSERT INTO property_tenants (tenant_id, property_id) VALUES (?, ?)";
		jdbcTemplate.update(sql, tenantId, propertyId);
	}

	@Override
	public void removeTenantFromProperty(int tenantId, int propertyId) {
		String sql = "DELETE FROM property_tenants WHERE tenant_id = ? AND property_id = ?";
		jdbcTemplate.update(sql, tenantId, propertyId);
	}

	private static class TenantRowMapper implements RowMapper<Tenant> {
		@Override
		public Tenant mapRow(ResultSet rs, int rowNum) throws SQLException {
			Tenant tenant = new Tenant();
			tenant.setTenantId(rs.getInt("tenant_id"));
			tenant.setTenantType(rs.getString("tenant_type"));
			tenant.setNoOfPerson(rs.getInt("no_of_person"));
			tenant.setTenantStatus(rs.getString("tenant_status"));
			tenant.setName(rs.getString("first_name")); // from users table
			tenant.setMobileNo(rs.getString("mobile_no"));
			tenant.setUserId(rs.getInt("user_id"));
			tenant.setPropertyTittle(rs.getString("property_title"));
			tenant.setPropertyId(rs.getInt("property_id"));
			return tenant;
		}
	}

	@Override
	public List<Tenant> getAssignedTenantsByProperty(Integer propertyId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional
	@Override
	public void updateTenantStatus(Integer tenantId, String tenantStatus, String propertyStatus) {
		// Update tenant status
		String tenantSql = "UPDATE tenants SET tenant_status = ? WHERE tenant_id = ?";
		jdbcTemplate.update(tenantSql, tenantStatus, tenantId);

		// Update property status
		String propertySql = "UPDATE property SET status = ? WHERE property_id = "
				+ "(SELECT property_id FROM tenants WHERE tenant_id = ?)";
		jdbcTemplate.update(propertySql, propertyStatus, tenantId);

		if ("active".equalsIgnoreCase(tenantStatus)) {

			// Retrieve property_id, price, and manager_id from the property table
			String selectPropertySql = "SELECT property_id, price, manager_id FROM property WHERE property_id = "
					+ "(SELECT property_id FROM tenants WHERE tenant_id = ?)";
			Map<String, Object> propertyData = jdbcTemplate.queryForMap(selectPropertySql, tenantId);

			Integer propertyId = (Integer) propertyData.get("property_id");
			BigDecimal rentAmount = (BigDecimal) propertyData.get("price");
			Integer managerId = (Integer) propertyData.get("manager_id");

			// Check if manager_id exists in the user table
			if (managerId != null) {
				String checkManagerSql = "SELECT COUNT(*) FROM user WHERE user_id = ?";
				int managerExists = jdbcTemplate.queryForObject(checkManagerSql, Integer.class, managerId);

				if (managerExists > 0) {
					// Insert with manager_id if it exists
					String leaseSql = "INSERT INTO lease_agreements (property_id, tenant_id, landlord_id, manager_id, start_date, end_date, rent_amount, security_deposit) "
							+ "VALUES (?, ?, 1, ?, CURRENT_DATE, CURRENT_DATE + INTERVAL 1 YEAR, ?, 15000)";
					jdbcTemplate.update(leaseSql, propertyId, tenantId, managerId, rentAmount);
				} else {
					// Insert without manager_id if it does not exist
					String leaseSql = "INSERT INTO lease_agreements (property_id, tenant_id, landlord_id, start_date, end_date, rent_amount, security_deposit) "
							+ "VALUES (?, ?, 1, CURRENT_DATE, CURRENT_DATE + INTERVAL 1 YEAR, ?, 15000)";
					jdbcTemplate.update(leaseSql, propertyId, tenantId, rentAmount);
				}
			} else {
				// Insert without manager_id if manager_id is null
				String leaseSql = "INSERT INTO lease_agreements (property_id, tenant_id, landlord_id, start_date, end_date, rent_amount, security_deposit) "
						+ "VALUES (?, ?, 1, CURRENT_DATE, CURRENT_DATE + INTERVAL 1 YEAR, ?, 15000)";
				jdbcTemplate.update(leaseSql, propertyId, tenantId, rentAmount);
			}
		} else {
			String updateLease = "UPDATE lease_agreements SET status = 'expired', end_date = CURRENT_DATE WHERE tenant_id = ?";
			jdbcTemplate.update(updateLease, tenantId);
		}
	}



	@Override
	public User getTenantProfile(int userId) {
		String sql = "SELECT * FROM user WHERE user_id = ?";
		return jdbcTemplate.queryForObject(sql, new UserRowMapper(), userId);
	}
}