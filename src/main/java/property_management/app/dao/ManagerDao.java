package property_management.app.dao;

import java.util.List;

import property_management.app.entities.Manager;

public interface ManagerDao {
	List<Manager> getAllManagers();

	void approveManager(int managerId);

	void rejectManager(int managerId);

	List<Manager> getApprovedManagers();

	// Manager findById(int managerId);
	void update(Manager manager);

	public Long findManagerIdByUserId(Long userId);

	public void approveManagerStatus(int managerId);

	void rejectManagerStatus(int managerId);

}
