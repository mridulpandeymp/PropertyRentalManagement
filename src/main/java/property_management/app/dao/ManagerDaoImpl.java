package property_management.app.dao;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import property_management.app.entities.Manager;

import java.util.List;

@Repository
public class ManagerDaoImpl implements ManagerDao {
	private final JdbcTemplate jdbcTemplate;

	public ManagerDaoImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Long findManagerIdByUserId(Long userId) {
		String sql = "SELECT * FROM managers WHERE user_id = ?";

		try {
			return jdbcTemplate.queryForObject(sql, new Object[] { userId }, Long.class);
		} catch (EmptyResultDataAccessException ex) {
			return null; // Or handle this case as needed, for example, return -1L or throw a custom
							// exception
		}
	}

	@Override
	public List<Manager> getAllManagers() {
		String sql = "SELECT m.*, u.first_name, u.mobile_no " + "FROM managers m "
				+ "JOIN user u ON m.user_id = u.user_id ";
		return jdbcTemplate.query(sql, new ManagerRowMapper());
	}

	@Override
	public void approveManager(int managerId) {
		String sql = "UPDATE user SET user.status = 'A' WHERE user.user_id IN "
				+ "(SELECT managers.user_id FROM managers WHERE managers.manager_id = ?) AND user.role_id = 2";
		jdbcTemplate.update(sql, managerId);
	}

	@Override
	public void approveManagerStatus(int managerId) {
		String sql = "UPDATE managers \r\n" + "SET status = true \r\n" + "WHERE manager_id = ?";
		jdbcTemplate.update(sql, managerId);
	}

	@Override
	public void rejectManager(int managerId) {
		String sql = "UPDATE user SET user.status = 'P' WHERE user.user_id IN "
				+ "(SELECT managers.user_id FROM managers WHERE managers.manager_id = ?) AND user.role_id = 2";
		jdbcTemplate.update(sql, managerId);
	}

	@Override
	public void rejectManagerStatus(int managerId) {
		String sql = "UPDATE managers \r\n" + "SET status = false \r\n" + "WHERE manager_id = ?";
		jdbcTemplate.update(sql, managerId);
	}

	@Override
	public List<Manager> getApprovedManagers() {
		String sql = "SELECT m.*, u.first_name, u.mobile_no " + "FROM managers m "
				+ "JOIN user u ON m.user_id = u.user_id WHERE u.status = 'A' ";
		return jdbcTemplate.query(sql, new ManagerRowMapper());
	}

	@Override
	public void update(Manager manager) {
		// TODO Auto-generated method stub

	}

}
