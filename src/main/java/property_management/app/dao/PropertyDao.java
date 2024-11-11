package property_management.app.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import javax.sql.rowset.serial.SerialException;

import property_management.app.entities.LeaseAgreement;
import property_management.app.entities.Manager;
import property_management.app.entities.Property;

public interface PropertyDao {

	int insertProperty(Property property) throws IOException, SerialException, SQLException;

	public List<Property> getLatestProperties();

	public List<Property> getAllProperties();


	public List<Property> findProperties(String search, String location, List<String> facilities);

	public Optional<Property> findPropertyById(int propertyId);

	public List<String> findUniqueLocations();

	public Integer findPropertyIdByUserId(int userId);
	public Optional<Integer> findPropertyIdByManagerId(Integer managerId);

	Double getAmountByTenantId(Long tenantId);
	
	List<Manager> getAssignedManagers(int propertyId);
    void assignManagerToProperty(int managerId, int propertyId);
    void unassignManagerFromProperty(int propertyId);
    
    public List<Property> getAllProperty();
    public int insertLeaseAgreement(LeaseAgreement leaseAgreement) throws IOException, SerialException, SQLException;
    public void deleteProperty(int propertyId);

	List<Property> viewAllPropertyStatus();

}
