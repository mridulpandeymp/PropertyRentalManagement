package property_management.app.dao;
 
 
import property_management.app.entities.Payment;
 
import org.springframework.jdbc.core.JdbcTemplate;
 
import org.springframework.stereotype.Repository;
 
@Repository

public class PaymentDaoImpl {

 
	    private final JdbcTemplate jdbcTemplate;
 
	    public PaymentDaoImpl(JdbcTemplate jdbcTemplate) {

	        this.jdbcTemplate = jdbcTemplate;

	    }
 
	    

	    public void savePayment(Payment payment) {

	        String sql = "INSERT INTO payment (tenant_id, payment_method, price, payment_date, receipt, manager_id) "

	                + "VALUES (?, ?, ?, ?, ?, ?)";

	        jdbcTemplate.update(sql, payment.getTenantId(), 

	                                    payment.getPaymentMethod(), 

	                                    payment.getPrice(),

	                                    payment.getPaymentDate(), 

	                                    payment.getReceipt(),

	                                    payment.getManagerId()); // Ensure to include manager_id if it's a part of your Payment entity

	    }

	}
 
 
 