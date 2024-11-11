package property_management.app.dao;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.jdbc.core.JdbcTemplate;

import property_management.app.entities.Manager;

public class ManagerDaoImplTest {

	@Mock
	private JdbcTemplate jdbcTemplate;

	@InjectMocks
	private ManagerDaoImpl managerDao;

	Manager manager1 = new Manager();
	Manager manager2 = new Manager();

	List<Manager> mockManagers;

	@BeforeEach
	public void setUp() {
		MockitoAnnotations.openMocks(this);

		// Prepare mock data
		manager1.setManagerId(1);
		manager1.setExperience_years(5);
		manager1.setApproved(false);

		manager2.setManagerId(2);
		manager2.setExperience_years(10);
		manager2.setApproved(true);

		mockManagers = Arrays.asList(manager1, manager2);
	}

	@Test
	public void testGetAllManagers() {

		when(jdbcTemplate.query(anyString(), any(ManagerRowMapper.class))).thenReturn(mockManagers);

		List<Manager> managers = managerDao.getAllManagers();

		assertNotNull(managers);
		assertEquals(2, managers.size());
		assertEquals(1, managers.get(0).getManagerId());
		assertEquals(5, managers.get(0).getExperience_years());
		assertEquals(false, managers.get(0).isApproved());

		assertEquals(2, managers.get(1).getManagerId());
		assertEquals(10, managers.get(1).getExperience_years());
		assertEquals(true, managers.get(1).isApproved());
	}

	@Test
	public void testApproveManager() {
		int managerId = 1;

		when(jdbcTemplate.update(anyString(), eq(managerId))).thenReturn(1);

		managerDao.approveManager(managerId);

		verify(jdbcTemplate, times(1)).update("UPDATE managers SET approved = TRUE WHERE manager_id = ?", managerId);
	}

	@Test
	public void testRejectManager() {
		int managerId = 2;

		when(jdbcTemplate.update(anyString(), eq(managerId))).thenReturn(1);

		managerDao.rejectManager(managerId);

		verify(jdbcTemplate, times(1)).update("UPDATE managers SET approved = FALSE WHERE manager_id = ?", managerId);
	}

	@Test
	public void testGetApprovedManagers() {
		when(jdbcTemplate.query(anyString(), any(ManagerRowMapper.class)))
				.thenAnswer(invocation -> mockManagers.stream().filter(Manager::isApproved).toList());

		List<Manager> result = managerDao.getApprovedManagers();

		assertEquals(mockManagers.stream().filter(Manager::isApproved).count(), result.size());

		verify(jdbcTemplate, times(1)).query(anyString(), any(ManagerRowMapper.class));
	}

}
