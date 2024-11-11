package property_management.app.dao;

import property_management.app.dao.LeaseAgreementDao;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import property_management.app.entities.LeaseAgreement;

import java.util.Collections;
import java.util.List;

@Repository
public class LeaseAgreementDaoImpl implements LeaseAgreementDao {

    private final JdbcTemplate jdbcTemplate;

    public LeaseAgreementDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<LeaseAgreement> getAllLeaseAgreements() {
        try {
            String sql = "SELECT * FROM lease_agreements";
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(LeaseAgreement.class));
        } catch (Exception e) {
            e.printStackTrace(); // Print exception details
            return Collections.emptyList(); // Return an empty list on error
        }
    }


    @Override
    public LeaseAgreement getLeaseAgreementById(int leaseId) {
        try {
            // SQL to fetch lease agreement by lease_id
            String sql = "SELECT * FROM lease_agreements WHERE lease_id = ?";
            
            // Use custom LeaseAgreementRowMapper
            LeaseAgreement leaseAgreement = jdbcTemplate.queryForObject(sql, 
                new Object[]{leaseId}, 
                new LeaseAgreementRowMapper());

            return leaseAgreement;
        } catch (Exception e) {
            e.printStackTrace(); // Print exception details
            return null; // Return null or handle as needed on error
        }
    }

    
    // New method to get all lease agreements by user_id (tenant_id)
    @Override
    public List<LeaseAgreement> getLeaseAgreementsByUserId(int userId) {
        try {
            // SQL to directly fetch lease agreements associated with the user via tenant_id
            String leaseSql = "select * from lease_agreements WHERE tenant_id = ?";
            
            List<LeaseAgreement> leaseAgreements = jdbcTemplate.query(leaseSql, 
                new Object[]{userId}, 
                new LeaseAgreementRowMapper());

            System.out.println("Lease Agreements fetched: " + leaseAgreements); // Log fetched lease agreements
            return leaseAgreements;
        } catch (Exception e) {
            e.printStackTrace(); // Print exception details
            return Collections.emptyList(); // Return an empty list on error
        }
    }


    
}
