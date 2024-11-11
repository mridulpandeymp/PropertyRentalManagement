package property_management.app.dao;

import property_management.app.entities.LeaseAgreement;
import property_management.app.entities.Manager;
import property_management.app.entities.Property;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.sql.rowset.serial.SerialException;

@Repository
public class PropertyDaoImpl implements PropertyDao {

	private final JdbcTemplate jdbcTemplate;

	public PropertyDaoImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	@Override
	public Optional<Integer> findPropertyIdByManagerId(Integer managerId) {
		String sql = "SELECT property_id FROM property WHERE manager_id = ?";

		try {
			 Integer propertyId = jdbcTemplate.queryForObject(sql, new Object[] { managerId }, Integer.class);
			return Optional.of(propertyId);
		} catch (EmptyResultDataAccessException ex) {
			return Optional.empty();
		}
	}

	@Override
	public void assignManagerToProperty(int managerId, int propertyId) {
		String sql = "UPDATE property SET manager_id = ? WHERE property_id = ?";
		jdbcTemplate.update(sql, managerId, propertyId);
	}

	@Override
	public void unassignManagerFromProperty(int propertyId) {
		String sql = "UPDATE property SET manager_id = NULL WHERE property_id = ?";
		jdbcTemplate.update(sql, propertyId);
	}
	
	@Override
	public void deleteProperty(int propertyId) {
		String sql = "UPDATE property SET status = 'inactive' WHERE property_id = ?";
		jdbcTemplate.update(sql, propertyId);
	}

	@Override
	public List<Manager> getAssignedManagers(int propertyId) {
		String sql = "SELECT m.* FROM managers m JOIN property p ON"
				+ " m.manager_id = p.manager_id WHERE p.property_id = ?";
		return jdbcTemplate.query(sql, new Object[] { propertyId }, new ManagerRowMapperNew());
	}
	
	private class ManagerRowMapperNew implements RowMapper<Manager> {

		public Manager mapRow(ResultSet rs, int rowNum) throws SQLException {
			Manager manager = new Manager();
			manager.setManagerId(rs.getInt("manager_id"));

			manager.setExperience_years(rs.getInt("experience_years"));
			manager.setApproved(rs.getBoolean("status"));
			return manager;

		}

	}

	@Override
	public Double getAmountByTenantId(Long tenantId) {
		String sql = "SELECT Price FROM Property WHERE tenant_id = ?"; // Adjust based on the actual column name
		try {
			return jdbcTemplate.queryForObject(sql, new Object[] { tenantId }, Double.class);
		} catch (EmptyResultDataAccessException e) {
			return null; // Or handle this case as needed
		}
	}

	// Fetch the latest properties to display on the homepage
	public List<Property> getLatestProperties() {
		String sql = "SELECT p.*,pt.type_name AS type FROM property p "
				+ "JOIN property_type pt ON p.type_id = pt.type_id " + "WHERE p.status = 'active' " // Add this line
				+ "ORDER BY p.CreatedAt ASC LIMIT 5";

		return jdbcTemplate.query(sql, new PropertyRowMapper());
	}

	// Fetch all properties
	public List<Property> getAllProperties() {

		String sql = "SELECT p.*, pt.type_name AS type FROM property p "
				+ "JOIN property_type pt ON p.type_id = pt.type_id" + "WHERE p.status = 'active' "; // Add this line
		return jdbcTemplate.query(sql, new PropertyRowMapper());

	}

	@Override
	public List<Property> getAllProperty() {
		String sql = "SELECT property_id,title FROM property";
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Property.class));
	}

	// Fetch properties based on search, location, and selected facilities
	public List<Property> findProperties(String search, String location, List<String> facilities) {
		// Base query to fetch properties
		StringBuilder sql = new StringBuilder("SELECT p.*, pt.type_name AS type FROM property p "
				+ "JOIN property_type pt ON p.type_id = pt.type_id " + "WHERE p.status = 'active' AND (" + // Add this
																											// line
				"p.title LIKE ? OR " + "p.description LIKE ? OR " + "p.city LIKE ? OR " + "p.address LIKE ? OR " + // Add
																													// more
																													// fields
																													// as
																													// needed
				"p.state LIKE ? OR " + "p.zip_code LIKE ?" + ")");

		// Add filtering based on the location
		if (location != null && !location.isEmpty()) {
			sql.append(" AND p.city LIKE ?");
		}

		// Add dynamic filtering based on facilities
		if (facilities != null && !facilities.isEmpty()) {
			if (facilities.contains("Swimming Pool")) {
				sql.append(" AND p.swimming_pool = 1");
			}
			if (facilities.contains("Gym")) {
				sql.append(" AND p.gym = 1");
			}
			if (facilities.contains("Parking")) {
				sql.append(" AND p.parking = 1");
			}
			if (facilities.contains("Garden")) {
				sql.append(" AND p.garden = 1");
			}
			if (facilities.contains("Air Conditioning")) {
				sql.append(" AND p.air_conditioning = 1");
			}
			if (facilities.contains("Elevator")) {
				sql.append(" AND p.elevator = 1");
			}
			if (facilities.contains("Security System")) {
				sql.append(" AND p.security_system = 1");
			}
			if (facilities.contains("Internet")) {
				sql.append(" AND p.internet = 1");
			}
			if (facilities.contains("Furnished")) {
				sql.append(" AND p.furnished = 1");
			}
		}

		// Prepare the search term with wildcards
		String searchTerm = "%" + (search != null ? search : "") + "%";
		List<Object> queryParams = new ArrayList<>();

		// Add search parameters for multiple fields
		queryParams.add(searchTerm); // For Title
		queryParams.add(searchTerm); // For Description
		queryParams.add(searchTerm); // For City
		queryParams.add(searchTerm); // For Address
		queryParams.add(searchTerm); // For State
		queryParams.add(searchTerm); // For ZipCode

		// Add location if specified
		if (location != null && !location.isEmpty()) {
			queryParams.add("%" + location + "%");
		}

		// Execute the query with the updated SQL and return the results
		return jdbcTemplate.query(sql.toString(), new PropertyRowMapper(), queryParams.toArray());

	}

	// Method to find a property by its ID
	public Optional<Property> findPropertyById(int propertyId) {
		String sql = "SELECT p.*, pt.type_name AS type " + "FROM property p "
				+ "JOIN property_type pt ON p.type_id = pt.type_id " + "WHERE p.property_id = ?";

		try {
			Property property = jdbcTemplate.queryForObject(sql, new Object[] { propertyId }, new PropertyRowMapper());
			return Optional.of(property); // Wrap the found property in an Optional
		} catch (EmptyResultDataAccessException e) {
			return Optional.empty(); // Return an empty Optional if no property is found
		}
	}

	// Fetch unique cities for the location dropdown
	public List<String> findUniqueLocations() {
		String sql = "SELECT DISTINCT city FROM property";
		return jdbcTemplate.queryForList(sql, String.class);
	}

	public Integer findPropertyIdByUserId(int userId) {
		String sql = "SELECT property_id FROM tenants WHERE user_id = ?";
		try {
			Integer propertyId = jdbcTemplate.queryForObject(sql, new Object[] { userId }, Integer.class);
			System.out.println("Property ID for User ID " + userId + ": " + propertyId);
			return propertyId;
		} catch (EmptyResultDataAccessException e) {
			// No records found, return null and log the situation
			System.out.println("No tenant data found for User ID " + userId + ". No property ID available.");
			return null; // Return null to indicate no tenant data found
		} catch (DataAccessException e) {
			// Handle other potential database access issues
			System.out.println(
					"Database error occurred while fetching property ID for User ID " + userId + ": " + e.getMessage());
			throw e; // Re-throw the exception or handle it according to your application's needs
		}
	}

	@Override
	public int insertProperty(Property property) throws IOException, SerialException, SQLException {

		String query = "INSERT INTO property "
				+ "(title, description, type_id, price, status, flat_no, floor, location, city, state, zip_code, latitude, longitude, swimming_pool, gym, parking, "
				+ "garden, air_conditioning, elevator, security_system, internet, furnished, image) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		byte[] propertyImageBytes = null;
		if (property.getImage() != null && !property.getImage().isEmpty()) {
			try {
				propertyImageBytes = property.getImage().getBytes();
			} catch (IOException e) {
				e.printStackTrace(); // Handle exception appropriately in production
			}
		}

		// Ensure all fields match with the placeholders in the query
		return jdbcTemplate.update(query, property.getTitle(), property.getDescription(), property.getType_id(),
				property.getPrice(), property.getStatus(), property.getFlatNo(), property.getFloor(),
				property.getAddress(), // Added missing address field
				property.getCity(), // Added missing city field
				property.getState(), property.getZip_code(), property.getLatitude(), property.getLongitude(),
				property.isSwimmingPool(), property.isGym(), property.isParking(), property.isGarden(),
				property.isAirConditioning(), property.isElevator(), property.isSecuritySystem(), property.isInternet(),
				property.isFurnished(), propertyImageBytes); // Blob for property image
	}

	@Override
	public int insertLeaseAgreement(LeaseAgreement leaseAgreement) throws IOException, SerialException, SQLException {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<Property> viewAllPropertyStatus() {
		String sql = "SELECT property_id, title, manager_id FROM property";
		return jdbcTemplate.query(sql, new LimitedPropertyRowMapper());
	}
 
	
//	@Override
//	public int insertLeaseAgreement(LeaseAgreement leaseAgreement) throws IOException, SerialException, SQLException {
//	    String query = "INSERT INTO lease_agreements "
//	                 + "(property_id, tenant_id, manager_id, rent_amount, security_deposit, start_date, end_date, status) "
//	                 + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
//	    
//
//	    return jdbcTemplate.update(query, leaseAgreement.getPropertyId(), leaseAgreement.getTenantId(),
//	            leaseAgreement.getManagerId(), leaseAgreement.getRentAmount());
//	}

	

//    @Override
//	public Double getAmountByTenantId(Long tenantId) {
//	    String sql = "SELECT Price FROM Property WHERE tenant_id = ?"; // Adjust based on the actual column name
//	    try {
//	        return jdbcTemplate.queryForObject(sql, new Object[]{tenantId}, Double.class);
//	    } catch (EmptyResultDataAccessException e) {
//	        return null; // Or handle this case as needed
//	    }
//	}

}