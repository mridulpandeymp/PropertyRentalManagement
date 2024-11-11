package property_management.app.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import property_management.app.entities.User;
import property_management.app.dao.MaintenanceRequestDao;
import property_management.app.dao.PropertyDao;

import property_management.app.dao.TenantDao;
import property_management.app.entities.Property;
import property_management.app.entities.Tenant;

@Controller
@RequestMapping("/tenant")
public class TenantController {

	private final PropertyDao propertyDao;

	private final TenantDao tenantDao;

	@Autowired
	public TenantController(TenantDao tenantDao, PropertyDao propertyDao) {
		this.propertyDao = propertyDao;
		this.tenantDao = tenantDao;
	}
	
	@Autowired
	private MaintenanceRequestDao maintenanceRequestDao;
	

	@GetMapping("/getAssignedTenants")
	public String getAssignedTenants(HttpSession session, Model model) {
		// Get the logged-in user from the session
		User loggedInUser = (User) session.getAttribute("user");
		Integer userId = loggedInUser.getUserId();
		System.out.println("user id :" + userId);
		Optional<Integer> managerIdOptional = maintenanceRequestDao.findManagerIdByUserId(userId);
		System.out.println(managerIdOptional);
//	    Integer managerId = managerIdOptional.get();

		// Step 1: Retrieve property IDs linked to the manager through the user

		// Step 2: Retrieve the managerId from the Property table using the propertyId

		if (managerIdOptional.isPresent()) {
			Integer managerId = managerIdOptional.get();
			System.out.println(managerId);
			Optional<Integer> propertyIdOptional = propertyDao.findPropertyIdByManagerId(managerId);
			System.out.println(propertyIdOptional);
			
			if (propertyIdOptional.isPresent()) {
				Integer propertyId = propertyIdOptional.get();
				System.out.println(propertyId);

				// Step 3: Retrieve the assigned tenants for the manager
				List<Tenant> assignedTenants = tenantDao.getAssignedTenantsByProperty(propertyId);
				System.out.println(assignedTenants);

				// Log the assigned tenants to verify
				System.out.println("Assigned tenants: " + assignedTenants);

				// Step 4: Add tenants to the model for the frontend
				model.addAttribute("assignedTenants", assignedTenants);

				return "tenant_management"; // Forward to the JSP page for displaying tenants
			} else {
				model.addAttribute("errorMessage", "Manager not found for the specified property.");
				return "errorPage";
			}
		} else {
			model.addAttribute("errorMessage", "No property found for this user.");
			return "errorPage";
		}
	}

	@GetMapping("/myPropertyDetails/{propertyId}")
	public String showPropertyDetails(@PathVariable int propertyId, Model model, HttpSession session) {
		Optional<Property> optionalProperty = propertyDao.findPropertyById(propertyId);
		if (optionalProperty.isPresent()) {
			model.addAttribute("property", optionalProperty.get());

			// Get logged-in user from session
			User loggedInUser = (User) session.getAttribute("loggedInUser");
			model.addAttribute("loggedInUser", loggedInUser);

			return "property_details"; // Assuming 'property_details.jsp'
		} else {
			model.addAttribute("errorMessage", "Property not found.");
			return "error_page"; // Handle error case
		}

	}

	@GetMapping("/addTenantDetails")
	public String addTenantDetails(@RequestParam("propertyId") int propertyId, Model model) {
		// Add logic to collect or initialize tenant details here
		Property property = propertyDao.findPropertyById(propertyId).orElse(null);

		if (property != null) {
			model.addAttribute("property", property);
		}

		// Redirect to a tenant details page (e.g., tenant_details.jsp)
		return "tenant_details";
	}

	@PostMapping("/save")
	public String saveTenant(@RequestParam String tenantType, @RequestParam int noOfPersons,
			@RequestParam String tenantStatus, @RequestParam int propertyId, @RequestParam int userId,
			HttpSession session, RedirectAttributes redirectAttributes, Model model) {
		Tenant tenant = new Tenant();
		tenant.setTenantType(tenantType);
		tenant.setNoOfPerson(noOfPersons);
		tenant.setTenantStatus(tenantStatus);
		tenant.setCreatedAt(new Timestamp(System.currentTimeMillis()));
		tenant.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
		tenant.setPropertyId(propertyId);
		tenant.setUserId(userId);

		tenantDao.saveTenant(tenant);

		model.addAttribute("tenantType", tenant.getTenantType());
		model.addAttribute("noOfPersons", tenant.getNoOfPerson());
		model.addAttribute("propertyId", tenant.getPropertyId());
		model.addAttribute("tenantId", tenant.getTenantId());

		// Set a success message and session attribute
		redirectAttributes.addFlashAttribute("successMessage", "Tenant registration successful!");
		session.setAttribute("formSubmitted", true); // Set session attribute

		return "tenant_success"; // Redirect to success page
	}
	
	@GetMapping("/tenantProfile/{userId}")
	public String viewProfile(@PathVariable int userId, Model model) throws IOException, SQLException {
		
		User tenantProfile = tenantDao.getTenantProfile(userId);
		if (tenantProfile.getProfileImage() != null && !tenantProfile.getProfileImage().isEmpty()) {
			byte[] imageBytes = tenantProfile.getProfileImage().getBytes();
			String base64Image = Base64.getEncoder().encodeToString(imageBytes);
			model.addAttribute("profileImage", base64Image);
		} else {
			model.addAttribute("profileImage", null);
		}
		
		if (tenantProfile.getIdProof() != null && !tenantProfile.getIdProof().isEmpty()) {

			byte[] imageBytes = tenantProfile.getIdProof().getBytes();
			String base64Image = Base64.getEncoder().encodeToString(imageBytes);
			model.addAttribute("idProof", base64Image);
		} else {
			model.addAttribute("idProof", null);
		}
		
		model.addAttribute("tenantProfile", tenantProfile);
		
		return "tenant_profile"; // The JSP page to display the profile
	}


	@GetMapping("/paymentPage")
	public String paymentPage() {
		return "payment";
	}

	@GetMapping("/submitPayment")
	public String submitPayment() {

		return "success";
	}

	@GetMapping("/maintenanceRequest")
	public String maintenanceRequest() {
		return "maintenance_request";
	}

	@GetMapping("/viewTenants")
	public String getAllTenants(Model model) {
		List<Tenant> tenantList = tenantDao.getAllTenants();
		model.addAttribute("tenantList", tenantList);
		return "view_tenants"; // Refers to view_tenants.jsp
	}
	
	@PostMapping("/updateStatus")
	public String updatePaymentStatus(@RequestParam("tenantId") Integer tenantId,
			@RequestParam("status") String status, RedirectAttributes redirectAttributes) throws SerialException, IOException, SQLException {
		
		 String propertyStatus;
		    if ("active".equalsIgnoreCase(status)) {
		        propertyStatus = "inactive";
		    } else if ("terminated".equalsIgnoreCase(status)) {
		        propertyStatus = "active";
		    } else {
		        propertyStatus = "active";  // Default or pending status for property if tenant is not approved
		    }
		
		tenantDao.updateTenantStatus(tenantId, status, propertyStatus);
		redirectAttributes.addFlashAttribute("message", "Tenant status updated successfully!");
	    redirectAttributes.addFlashAttribute("status", status);
		return "redirect:/tenant/viewTenants"; // Redirect to payments list
	}

	@PostMapping("/assignTenant")
	public String assignTenantToProperty(@RequestParam int tenantId, @RequestParam int propertyId) {
		tenantDao.assignTenantToProperty(tenantId, propertyId);
		return "redirect:/viewTenants";
	}

	@PostMapping("/removeTenant")
	public String removeTenantFromProperty(@RequestParam int tenantId, @RequestParam int propertyId) {
		tenantDao.removeTenantFromProperty(tenantId, propertyId);
		return "redirect:/viewTenants";
	}
}