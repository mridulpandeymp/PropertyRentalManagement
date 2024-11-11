package property_management.app.entities;

import java.time.LocalDate;
import java.util.Arrays;

public class Payment {

	private Long paymentId;
	private Long tenantId;
	private String paymentMethod;
	private Double price;
	private LocalDate paymentDate;
	private byte[] receipt;
	private Long managerId;

	private String bankDetails;
	private String upiDetails;
	private double amount;
	private String status;

	public String getBankDetails() {
		return bankDetails;
	}

	public void setBankDetails(String bankDetails) {
		this.bankDetails = bankDetails;
	}

	public String getUpiDetails() {
		return upiDetails;
	}

	public void setUpiDetails(String upiDetails) {
		this.upiDetails = upiDetails;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public Long getManagerId() {
		return managerId;
	}

	public void setManagerId(Long managerId) {
		this.managerId = managerId;
	}

	public Long getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(Long paymentId) {
		this.paymentId = paymentId;
	}

	public Long getTenantId() {
		return tenantId;
	}

	public void setTenantId(Long tenantId) {
		this.tenantId = tenantId;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public LocalDate getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(LocalDate paymentDate) {
		this.paymentDate = paymentDate;
	}

	public byte[] getReceipt() {
		return receipt;
	}

	public void setReceipt(byte[] receipt) {
		this.receipt = receipt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Payment [paymentId=" + paymentId + ", tenantId=" + tenantId + ", paymentMethod=" + paymentMethod
				+ ", price=" + price + ", paymentDate=" + paymentDate + "]";
	}
	
	
	

}
