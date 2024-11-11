package property_management.app.entities;

import java.math.BigDecimal;
import java.util.Date;

public class LeaseAgreement {
    private int leaseId;           // Primary key
    private int propertyId;        // Foreign key to Property
    private int landlordId;        // Foreign key to Landlord
    private int tenantId;          // Foreign key to Tenant
    private int managerId;         // Foreign key to Manager
    private Date leaseStartDate;   // Corresponds to start_date
    private Date leaseEndDate;     // Corresponds to end_date
    private BigDecimal rentAmount;  // Corresponds to rent_amount
    private BigDecimal securityDeposit; // Corresponds to security_deposit
    private byte[] leaseDocument;   // Corresponds to lease_document (longblob)
    private String status;          // Corresponds to status (enum)
    private BigDecimal depositAmount; // Added field for deposit amount
//    private String paymentSchedule;  // Added field for payment schedule
    private String agreementDetails; // Added field for agreement details

    // Default constructor
    public LeaseAgreement() {}

    // Parameterized constructor
    public LeaseAgreement(int leaseId, int propertyId, int landlordId, int tenantId, int managerId, 
                          Date leaseStartDate, Date leaseEndDate, BigDecimal rentAmount, 
                          BigDecimal securityDeposit, byte[] leaseDocument, String status, 
                          BigDecimal depositAmount, String agreementDetails) {
        this.leaseId = leaseId;
        this.propertyId = propertyId;
        this.landlordId = landlordId;
        this.tenantId = tenantId;
        this.managerId = managerId;
        this.leaseStartDate = leaseStartDate;
        this.leaseEndDate = leaseEndDate;
        this.rentAmount = rentAmount;
        this.securityDeposit = securityDeposit;
        this.leaseDocument = leaseDocument;
        this.status = status;
        this.depositAmount = depositAmount;
//        this.paymentSchedule = paymentSchedule;
        this.agreementDetails = agreementDetails;
    }

    // Getters and setters
    public int getLeaseId() {
        return leaseId;
    }

    public void setLeaseId(int leaseId) {
        this.leaseId = leaseId;
    }

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public int getLandlordId() {
        return landlordId;
    }

    public void setLandlordId(int landlordId) {
        this.landlordId = landlordId;
    }

    public int getTenantId() {
        return tenantId;
    }

    public void setTenantId(int tenantId) {
        this.tenantId = tenantId;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public Date getLeaseStartDate() {
        return leaseStartDate;
    }

    public void setLeaseStartDate(Date leaseStartDate) {
        this.leaseStartDate = leaseStartDate;
    }

    public Date getLeaseEndDate() {
        return leaseEndDate;
    }

    public void setLeaseEndDate(Date leaseEndDate) {
        this.leaseEndDate = leaseEndDate;
    }

    public BigDecimal getRentAmount() {
        return rentAmount;
    }

    public void setRentAmount(BigDecimal rentAmount) {
        this.rentAmount = rentAmount;
    }

    public BigDecimal getSecurityDeposit() {
        return securityDeposit;
    }

    public void setSecurityDeposit(BigDecimal securityDeposit) {
        this.securityDeposit = securityDeposit;
    }

    public byte[] getLeaseDocument() {
        return leaseDocument;
    }

    public void setLeaseDocument(byte[] leaseDocument) {
        this.leaseDocument = leaseDocument;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getDepositAmount() {
        return depositAmount;
    }

    public void setDepositAmount(BigDecimal depositAmount) {
        this.depositAmount = depositAmount;
    }

//    public String getPaymentSchedule() {
//        return paymentSchedule;
//    }
//
//    public void setPaymentSchedule(String paymentSchedule) {
//        this.paymentSchedule = paymentSchedule;
//    }

    public String getAgreementDetails() {
        return agreementDetails;
    }

    public void setAgreementDetails(String agreementDetails) {
        this.agreementDetails = agreementDetails;
    }

    @Override
    public String toString() {
        return "LeaseAgreement{" +
                "leaseId=" + leaseId +
                ", propertyId=" + propertyId +
                ", landlordId=" + landlordId +
                ", tenantId=" + tenantId +
                ", managerId=" + managerId +
                ", leaseStartDate=" + leaseStartDate +
                ", leaseEndDate=" + leaseEndDate +
                ", rentAmount=" + rentAmount +
                ", securityDeposit=" + securityDeposit +
                ", depositAmount=" + depositAmount +
//                ", paymentSchedule='" + paymentSchedule + '\'' +
                ", agreementDetails='" + agreementDetails + '\'' +
                ", status='" + status + '\'' +
                '}';
    }

    // Override equals and hashCode as needed
}
