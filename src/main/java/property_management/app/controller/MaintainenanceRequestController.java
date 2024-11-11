package property_management.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import property_management.app.entities.MaintenanceRequest;
import property_management.app.entities.User;
import property_management.app.dao.MaintenanceRequestDao;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Controller
public class MaintainenanceRequestController {

	@Autowired
	private MaintenanceRequestDao maintenanceRequestDao;
	
	
	private MaintenanceRequest maintenanceRequest;
	

	@PostMapping("/api/maintenance/submit")
	public ResponseEntity<String> submitRequest(@RequestParam("request_type") String requestType,
			@RequestParam("description") String description, @RequestParam("photo") MultipartFile photo,
			@RequestParam("tenantId") Integer tenantId, HttpSession session) {
		System.out.println("kjwjd"+requestType);
		try {
			MaintenanceRequest request = new MaintenanceRequest();
			request.setRequestType(requestType);
			request.setDescription(description);
			System.out.println(request);

			if (!photo.isEmpty()) {
				byte[] photoBytes = photo.getBytes();
				request.setPhoto(photoBytes);
			}
			
			
			System.out.println(maintenanceRequest);
			

			maintenanceRequestDao.saveRequest(request);
			return ResponseEntity.ok("Request is submitted successfully!");

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("Failed to submit the request: " + e.getMessage());
		}
	}

	@GetMapping("/maintenance-requests")
	public String getAllRequests(Model model) {
		List<MaintenanceRequest> requests = maintenanceRequestDao.getAllRequests();
		model.addAttribute("requests", requests != null ? requests : Collections.emptyList());
		return "manager_maintenance"; // Refers to maintenanceRequests.jsp
	}
	
	@PostMapping("/maintenanceUpdateStatus")
	public String maintenanceUpdateStatus(@RequestParam("maintenanceId") int maintenanceId,
			@RequestParam("status") String status) {
		maintenanceRequestDao.updateMaintenanceStatus(maintenanceId, status);
		return "redirect:/maintenance-requests"; // Redirect to payments list
	}

	@GetMapping("/getAssignRequests")
	public String getAssignRequest(HttpSession session, Model model) {
		User loggedInUser = (User) session.getAttribute("user");
		Integer userId = (Integer)loggedInUser.getUserId();
		System.out.println("hiii" + loggedInUser);
		System.out.println(userId);

		// Fetch managerId using Optional
		Optional<Integer> managerIdOptional = maintenanceRequestDao.findManagerIdByUserId(userId);

		if (managerIdOptional.isPresent()) {

			Integer managerId = managerIdOptional.get();
			List<MaintenanceRequest> assignedRequests = maintenanceRequestDao.getAssignedRequests(managerId);
			model.addAttribute("assignedRequests", assignedRequests);
			return "assignedRequests";
		} else {
			model.addAttribute("errorMessage", "Manager not found for this user.");
			return "errorPage"; // Make sure to handle this in the view
		}
	}

}
