package property_management.app.dao;

import property_management.app.entities.Tenant;
import property_management.app.entities.User;

import java.util.List;

public interface TenantDao {
	Tenant getTenantByUserId(int userId);

	List<Tenant> getAllTenants();

	void saveTenant(Tenant tenant);

	void updateTenant(Tenant tenant);

	void deleteTenant(int tenantId);

	void assignTenantToProperty(int tenantId, int propertyId);

	void removeTenantFromProperty(int tenantId, int propertyId);

	List<Tenant> getAssignedTenantsByProperty(Integer propertyId);

	public List<Tenant> getAssignedTenants(int managerId);

	public void updateTenantStatus(Integer tenantId, String tenantStatus, String propertyStatus);
	
	User getTenantProfile(int userId);
}
