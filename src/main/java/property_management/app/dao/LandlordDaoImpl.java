package property_management.app.dao;

import property_management.app.entities.Landlord;
import property_management.app.entities.Payment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class LandlordDaoImpl implements LandlordDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public Landlord getLandlordDetails() {
		String sql = "SELECT bank_details, upi_details FROM landlord WHERE id = 1"; // Assuming one landlord
		try {
			return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
				Landlord landlord = new Landlord();
				landlord.setBankDetails(rs.getString("bank_details"));
				landlord.setUpiDetails(rs.getString("upi_details"));
				return landlord;
			});
		} catch (EmptyResultDataAccessException e) {
			// Handle case when no landlord is found
			return null; // or throw a custom exception
		}
	}

	public List<Payment> getAllPayments() {
		String sql = "SELECT * FROM payment ";
		return jdbcTemplate.query(sql, new PaymentRowMapper());
	}

	public void updatePaymentStatus(int paymentId, String status) {
		String sql = "UPDATE payment SET status = ? WHERE payment_id = ?";
		jdbcTemplate.update(sql, status, paymentId);
	}

}