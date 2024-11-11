package property_management.app.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import property_management.app.entities.Payment;

public class PaymentRowMapper implements RowMapper<Payment> {

	 @Override
     public Payment mapRow(ResultSet rs, int rowNum) throws SQLException {
         Payment payment = new Payment();
         payment.setPaymentId(rs.getLong("payment_id"));
         payment.setTenantId(rs.getLong("tenant_id"));
         payment.setAmount(rs.getDouble("price"));
         payment.setPaymentMethod(rs.getString("payment_method"));
         payment.setPaymentDate(rs.getDate("payment_date").toLocalDate());
         payment.setReceipt(rs.getBytes("receipt"));
         payment.setStatus(rs.getNString("status"));
         
         return payment;
     }

}
