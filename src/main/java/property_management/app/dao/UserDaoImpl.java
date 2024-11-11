package property_management.app.dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import property_management.app.entities.Manager;
import property_management.app.entities.Role;
import property_management.app.entities.User;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int insertUser(User user) {
		String sql = "INSERT INTO user (first_name, last_name, email_id, mobile_no, date_of_birth, username, passwordSalt, passwordHash, status, role_id, profile_image, id_proof) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		// Convert MultipartFile to byte array
		byte[] profileImageBytes = null;
		if (user.getProfileImage() != null && !user.getProfileImage().isEmpty()) {
			try {
				profileImageBytes = user.getProfileImage().getBytes();
			} catch (IOException e) {
				e.printStackTrace(); // Handle exception appropriately in production
			}
		}

		byte[] idProofBytes = null;
		if (user.getIdProof() != null && !user.getIdProof().isEmpty()) {
			try {
				idProofBytes = user.getIdProof().getBytes();
			} catch (IOException e) {
				e.printStackTrace(); // Handle exception appropriately in production
			}
		}

		return jdbcTemplate.update(sql, user.getFirstName(), user.getLastName(), user.getEmailId(), user.getMobileNo(),
				user.getDateOfBirth(), user.getUsername(), user.getPasswordSalt(), user.getPasswordHash(),
				user.getStatus(), user.getRole().getRoleId(), profileImageBytes, idProofBytes);
	}

	@Override
	public int insertManager(User user, Manager manager) throws SQLException {
		int result = 0; // Initialize the result to track the overall operation success
		try {
			// Step 1: Insert into the 'user' table and retrieve the generated user_id
			String userSql = "INSERT INTO user (first_name, last_name, email_id, mobile_no, date_of_birth, username, passwordSalt, passwordHash, status, role_id, profile_image, id_proof) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			KeyHolder keyHolder = new GeneratedKeyHolder();
			int rowsAffectedUser = jdbcTemplate.update(connection -> {
				PreparedStatement ps = connection.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);
				ps.setString(1, user.getFirstName());
				ps.setString(2, user.getLastName());
				ps.setString(3, user.getEmailId());
				ps.setString(4, user.getMobileNo());
				ps.setDate(5, new java.sql.Date(user.getDateOfBirth().getTime()));
				ps.setString(6, user.getUsername());
				ps.setString(7, user.getPasswordSalt());
				ps.setString(8, user.getPasswordHash());
				ps.setString(9, user.getStatus());
				ps.setInt(10, user.getRole().getRoleId());
				byte[] profileImageBytes = null;
				if (user.getProfileImage() != null && !user.getProfileImage().isEmpty()) {
					try {
						profileImageBytes = user.getProfileImage().getBytes();
					} catch (IOException e) {
						e.printStackTrace(); // Handle exception appropriately in production
					}
				}

				ps.setBytes(11, profileImageBytes);

				byte[] idProofBytes = null;
				if (user.getIdProof() != null && !user.getIdProof().isEmpty()) {
					try {
						idProofBytes = user.getIdProof().getBytes();
					} catch (IOException e) {
						e.printStackTrace(); // Handle exception appropriately in production
					}
				}
				ps.setBytes(12, idProofBytes);
				return ps;
			}, keyHolder);

			if (rowsAffectedUser > 0) {
				// Retrieve the generated user_id from the user table
				int userId = keyHolder.getKey().intValue();

				// Step 2: Insert into the 'manager' table using the generated user_id
				String managerSql = "INSERT INTO managers (user_id, experience_years, resume) VALUES (?, ?, ?)";

				byte[] resumeBytes = null;
				if (manager.getResume() != null && !manager.getResume().isEmpty()) {
					try {
						resumeBytes = manager.getResume().getBytes();
					} catch (IOException e) {
						e.printStackTrace(); // Handle exception appropriately in production
					}
				}

				int rowsAffectedManager = jdbcTemplate.update(managerSql, userId, manager.getExperience_years(),
						resumeBytes);

				// If both insertions are successful, return 1 as success
				if (rowsAffectedManager > 0) {
					result = 1; // Successfully inserted into both tables
				}
			}
		} catch (DataAccessException e) {
			throw new SQLException("Error while saving manager details.", e);
		}

		return result;
	}

	@Override
	public List<Role> fetchAllRoles() {
		String sql = "SELECT * FROM roles WHERE role_id > 1 ORDER BY role_id";
		return jdbcTemplate.query(sql, new RolesRowMapper());
	}

	@Override
	public Map<String, Object> fetchPwds(String username) {
		String sql = "SELECT passwordSalt, passwordHash, role_id, status FROM user WHERE username = ?";
		return jdbcTemplate.queryForMap(sql, username);
	}

	@Override
	public User fetchUser(String username) {
		String sql = "SELECT * FROM user WHERE username = ?";
		return jdbcTemplate.queryForObject(sql, new UserRowMapper(), username);

	}

	@Override
	public User getUserById(int userId) {
		String sql = "SELECT * FROM user WHERE user_id = ?";
		return jdbcTemplate.queryForObject(sql, new UserRowMapper(), userId);
	}

	@Override
	public boolean updateUser(User user) {
		String sql = "UPDATE user SET first_name = ?, last_name = ?, email_id = ?, mobile_no = ?, date_of_birth = ?, username = ?,  profile_image = ?, id_proof = ? WHERE user_id = ?";
		try {
			int result = jdbcTemplate.update(sql, user.getFirstName(), user.getLastName(), user.getEmailId(),
					user.getMobileNo(), user.getDateOfBirth(), user.getUsername(),
					user.getProfileImage().getBytes(), user.getIdProof().getBytes(), user.getUserId());
			return result > 0;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public User findByEmail(String email) {
		String sql = "SELECT * FROM user WHERE email_id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new Object[] { email }, new UserRowMapper());
		} catch (EmptyResultDataAccessException e) {
			// User not found, return null
			return null;
		}
	}

	@Override
	public int forgotUserPassword(String email, String passwordHash, String passwordSalt) {
		String sql = "UPDATE user SET passwordHash = ?, passwordSalt = ? WHERE email_id = ?";
		return jdbcTemplate.update(sql, passwordHash, passwordSalt, email);
	}

}
