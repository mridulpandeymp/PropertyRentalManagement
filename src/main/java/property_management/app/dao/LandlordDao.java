package property_management.app.dao;

import java.util.List;

import property_management.app.entities.*;

public interface LandlordDao {

	Landlord getLandlordDetails();

	public List<Payment> getAllPayments();

	public void updatePaymentStatus(int paymentId, String status);
}
