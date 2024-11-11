package property_management.app.dao;

import property_management.app.entities.MaintenanceRequest;

import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MaintenanceRequestDao {

	public void saveRequest(MaintenanceRequest request) throws SQLException;

	List<MaintenanceRequest> getAllRequests();

	List<MaintenanceRequest> getAssignedRequests(int managerId);

	public Optional<Integer> findManagerIdByUserId(Integer userId);

	public void updateMaintenanceStatus(int maintenanceId, String status);
}
