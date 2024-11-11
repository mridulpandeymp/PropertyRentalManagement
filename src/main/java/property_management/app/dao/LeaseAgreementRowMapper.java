package property_management.app.dao;

import org.springframework.jdbc.core.RowMapper;
import property_management.app.entities.LeaseAgreement;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;

public class LeaseAgreementRowMapper implements RowMapper<LeaseAgreement> {
    @Override
    public LeaseAgreement mapRow(ResultSet rs, int rowNum) throws SQLException {
        LeaseAgreement leaseAgreement = new LeaseAgreement();
        leaseAgreement.setLeaseId(rs.getInt("lease_id"));
        leaseAgreement.setTenantId(rs.getInt("tenant_id"));
        leaseAgreement.setPropertyId(rs.getInt("property_id"));
        leaseAgreement.setLandlordId(rs.getInt("landlord_id"));
        leaseAgreement.setManagerId(rs.getInt("manager_id"));
        leaseAgreement.setLeaseStartDate(rs.getDate("start_date"));
        leaseAgreement.setLeaseEndDate(rs.getDate("end_date"));
        leaseAgreement.setRentAmount(rs.getBigDecimal("rent_amount"));
        leaseAgreement.setSecurityDeposit(rs.getBigDecimal("security_deposit"));
//        leaseAgreement.setLeaseDocument(rs.getString("lease_document")); // Adjust if type is different
        leaseAgreement.setStatus(rs.getString("status"));

        return leaseAgreement;
    }
}
