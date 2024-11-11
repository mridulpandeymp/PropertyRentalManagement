package property_management.app.dao;


import java.util.List;

import property_management.app.entities.LeaseAgreement;

public interface LeaseAgreementDao {
    List<LeaseAgreement> getAllLeaseAgreements();
    LeaseAgreement getLeaseAgreementById(int leaseId);
    List<LeaseAgreement> getLeaseAgreementsByUserId(int userId);

}
