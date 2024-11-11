package property_management.app.entities;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Arrays;

public class MaintenanceRequest {

	private int maintenanceId;

	private String requestType;

	private String description;

	private byte[] photo;

	private String status;

	private Integer userId;

	private Integer managerId;

	private Integer tenantId;

	private LocalDateTime requestedDate;

	private LocalDateTime resolvedDate;

	private BigDecimal finalCost;

	public MaintenanceRequest() {
		super();
	}

	public MaintenanceRequest(int maintenanceId, String requestType, String description, byte[] photo, String status,
			Integer userId, Integer managerId, Integer tenantId, LocalDateTime requestedDate,
			LocalDateTime resolvedDate, BigDecimal finalCost) {
		super();
		this.maintenanceId = maintenanceId;
		this.requestType = requestType;
		this.description = description;
		this.photo = photo;
		this.status = status;
		this.userId = userId;
		this.managerId = managerId;
		this.tenantId = tenantId;
		this.requestedDate = requestedDate;
		this.resolvedDate = resolvedDate;
		this.finalCost = finalCost;
	}

	public int getMaintenanceId() {

		return maintenanceId;

	}

	public void setMaintenanceId(int maintenanceId) {

		this.maintenanceId = maintenanceId;

	}

	public String getRequestType() {

		return requestType;

	}

	public void setRequestType(String requestType) {

		this.requestType = requestType;

	}

	public String getDescription() {

		return description;

	}

	public void setDescription(String description) {

		this.description = description;

	}

	public byte[] getPhoto() {

		return photo;

	}

	public void setPhoto(byte[] photo) {

		this.photo = photo;

	}

	public String getStatus() {

		return status;

	}

	public void setStatus(String status) {

		this.status = status;

	}

	public Integer getUserId() {

		return userId;

	}

	public void setUserId(Integer userId) {

		this.userId = userId;

	}

	public Integer getManagerId() {

		return managerId;

	}

	public void setManagerId(Integer managerId) {

		this.managerId = managerId;

	}

	public Integer getTenantId() {

		return tenantId;

	}

	public void setTenantId(Integer tenantId2) {

		this.tenantId = tenantId2;

	}

	public LocalDateTime getRequestedDate() {

		return requestedDate;

	}

	public void setRequestedDate(LocalDateTime requestedDate) {

		this.requestedDate = requestedDate;

	}

	public LocalDateTime getResolvedDate() {

		return resolvedDate;

	}

	public void setResolvedDate(LocalDateTime resolvedDate) {

		this.resolvedDate = resolvedDate;

	}

	public BigDecimal getFinalCost() {

		return finalCost;

	}

	public void setFinalCost(BigDecimal finalCost) {

		this.finalCost = finalCost;

	}

	public void setRequestedDate(Timestamp timestamp) {
		// TODO Auto-generated method stub

	}

	public void setResolvedDate(Timestamp timestamp) {
		// TODO Auto-generated method stub

	}

	@Override
	public String toString() {
		return "MaintenanceRequest [maintenanceId=" + maintenanceId + ", requestType=" + requestType + ", description="
				+ description + ", photo=" + Arrays.toString(photo) + ", status=" + status + ", userId=" + userId
				+ ", managerId=" + managerId + ", tenantId=" + tenantId + ", requestedDate=" + requestedDate
				+ ", resolvedDate=" + resolvedDate + ", finalCost=" + finalCost + "]";
	}

	// Getters and Setters

	// (Omitted for brevity; generate these using your IDE)

}
