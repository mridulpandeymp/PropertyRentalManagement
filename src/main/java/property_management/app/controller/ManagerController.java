package property_management.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import property_management.app.dao.ManagerDao;
import property_management.app.dao.PropertyDao;
import property_management.app.dao.UserDao;
import property_management.app.entities.Manager;
import property_management.app.entities.Property;
import property_management.app.entities.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;

@Controller
public class ManagerController {

	@Autowired
	private ManagerDao managerDao;

	@Autowired
	private PropertyDao propertyDao;
	
	@Autowired
	private UserDao userDao;

	@GetMapping("/approveRejectManagers")
	public String approveRejectManagers(Model model, HttpSession session) {
		System.out.println("Entered approveRejectManagers method");

		List<Manager> managers = managerDao.getAllManagers(); // Get all managers
		model.addAttribute("managers", managers);

		// Print each manager's details
		if (managers != null && !managers.isEmpty()) {
			for (Manager manager : managers) {
				System.out.println("Manager ID: " + manager.getManagerId() + ", Experience: "
						+ manager.getExperience_years() + ", Approved: ");
			}
		} else {
			System.out.println("No managers found.");
		}

		return "approveRejectManagers"; // JSP page name
	}
	
	
	@GetMapping("/managerProfile/{userId}")
	public String viewProfile(@PathVariable int userId, Model model) throws IOException, SQLException {
		
		User managerProfile = userDao.getUserById(userId);
		if (managerProfile.getProfileImage() != null && !managerProfile.getProfileImage().isEmpty()) {
			byte[] imageBytes = managerProfile.getProfileImage().getBytes();
			String base64Image = Base64.getEncoder().encodeToString(imageBytes);
			model.addAttribute("profileImage", base64Image);
		} else {
			model.addAttribute("profileImage", null);
		}
		
		if (managerProfile.getIdProof() != null && !managerProfile.getIdProof().isEmpty()) {

			byte[] imageBytes = managerProfile.getIdProof().getBytes();
			String base64Image = Base64.getEncoder().encodeToString(imageBytes);
			model.addAttribute("idProof", base64Image);
		} else {
			model.addAttribute("idProof", null);
		}
		
		model.addAttribute("managerProfile", managerProfile);
		
		return "manager_profile"; // The JSP page to display the profile
	}
	

 

	@PostMapping("/approveManager")
	public String approveManager(@RequestParam int managerId, RedirectAttributes redirectAttributes) {
		managerDao.approveManager(managerId);
		managerDao.approveManagerStatus(managerId);
		redirectAttributes.addFlashAttribute("message", "Manager approved successfully!");
		// return approveRejectManagers(model);
		return "redirect:/approveRejectManagers";
	}

	@PostMapping("/rejectManager")
	public String rejectManager(@RequestParam int managerId, RedirectAttributes redirectAttributes) {
		managerDao.rejectManager(managerId);
		managerDao.rejectManagerStatus(managerId);
		redirectAttributes.addFlashAttribute("message", "Manager rejected successfully!");
		return "redirect:/approveRejectManagers";
	}

	@GetMapping("/assignManagers")
	public String showAssignManagersPage(Model model) {

		List<Manager> approvedManagers = managerDao.getApprovedManagers();
		List<Property> properties = propertyDao.getAllProperty();

		model.addAttribute("approvedManagers", approvedManagers);
		model.addAttribute("properties", properties);
		return "assign_managers"; // JSP page name
	}

	@PostMapping("/assignManager")
	public String assignManager(@RequestParam int managerId, @RequestParam int propertyId,
			RedirectAttributes redirectAttributes, Model model) {
		propertyDao.assignManagerToProperty(managerId, propertyId);

		List<Manager> assignedManagers = propertyDao.getAssignedManagers(propertyId);
		List<Property> properties = propertyDao.getAllProperty();
		System.out.println(
				"Manager assigned to a property " + "manager id = " + managerId + " " + "property id = " + propertyId);
		model.addAttribute("assignedManagers", assignedManagers);
		model.addAttribute("properties", properties);
		model.addAttribute("propertyId", propertyId);
		redirectAttributes.addFlashAttribute("message", "Manager assigned successfully!");
		return "redirect:/assignManagers";
	}

	@PostMapping("/unassignManager")
	public String unassignManager(@RequestParam int propertyId, Model model) {
		propertyDao.unassignManagerFromProperty(propertyId);
		model.addAttribute("message", "Manager unassigned successfully!");
		return showAssignManagersPage(model);
	}
	
	
	@GetMapping("/viewAssignManagers")
	public String viewAssignManagersPage(Model model) {
		
		List<Property> viewListOfAssingManagers = propertyDao.viewAllPropertyStatus();
		model.addAttribute("viewListOfAssingManagers", viewListOfAssingManagers);
		
		return "view_assign_managers"; // JSP page name
	}

}
