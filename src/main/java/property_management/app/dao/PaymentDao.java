package property_management.app.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import property_management.app.entities.Payment;

@Repository
public class PaymentDao {

	private final JdbcTemplate jdbcTemplate;

	public PaymentDao(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<Payment> getAssignedPayments(int managerId) {
		String sql = "SELECT * FROM payment WHERE manager_id = ?";
		return jdbcTemplate.query(sql, new PaymentRowMapper(), managerId);
	}

	public void updatePaymentStatus(int paymentId, String status) {
		String sql = "UPDATE payment SET status = ? WHERE payment_id = ?";
		jdbcTemplate.update(sql, status, paymentId);
	}

	// Save payment
	public void savePayment(Payment payment) {
		String sql = "INSERT INTO payment (tenant_id, payment_method, price, payment_date, receipt, manager_id) VALUES (?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, payment.getTenantId(), payment.getPaymentMethod(), payment.getPrice(),
				payment.getPaymentDate(), payment.getReceipt(), payment.getManagerId());
	}

	// Fetch payments by manager
	public List<Payment> getPaymentsByManager(Long managerId) {
		String sql = "SELECT * FROM payment WHERE manager_id = ?";
		return jdbcTemplate.query(sql, new Object[] { managerId }, new PaymentRowMapper());
	}

	// Payment RowMapper class
	private static class PaymentRowMapper implements RowMapper<Payment> {
		@Override
		public Payment mapRow(ResultSet rs, int rowNum) throws SQLException {
			Payment payment = new Payment();
			payment.setPaymentId(rs.getLong("payment_id"));
			payment.setTenantId(rs.getLong("tenant_id"));
			payment.setPaymentMethod(rs.getString("payment_method"));
			payment.setPrice(rs.getDouble("price"));
			payment.setPaymentDate(rs.getDate("payment_date").toLocalDate());
			payment.setReceipt(rs.getBytes("receipt"));
			payment.setManagerId(rs.getLong("manager_id"));
			payment.setStatus(rs.getString("status"));
			return payment;
		}

	}

}
