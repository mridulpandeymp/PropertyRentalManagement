package property_management.app.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import property_management.app.dao.LandlordDao;
import property_management.app.dao.PropertyDao;
import property_management.app.dao.PropertyDaoImpl;
import property_management.app.dao.UserDaoImpl;
import property_management.app.entities.Landlord;
import property_management.app.entities.Payment;
import property_management.app.entities.Property;
import property_management.app.entities.User;

@Controller
@RequestMapping("/landlord")
public class LandlordController {

	@Autowired
	UserDaoImpl userDaoImpl;

	@Autowired
	PropertyDao propertyDao;

	@Autowired
	private LandlordDao landlordDao;

	@Autowired
	private final PropertyDaoImpl propertyDaoImpl;

	public LandlordController(PropertyDaoImpl propertyDaoImpl) {

		this.propertyDaoImpl = propertyDaoImpl;
	}

	@GetMapping("/getAllPayments")
	public ModelAndView getAllPayments(HttpSession session) {

		ModelAndView modelAndView = new ModelAndView();

		List<Payment> allPayments = landlordDao.getAllPayments();
		System.out.println("allPayments :" + allPayments);

		// Set the assigned payments in the ModelAndView
		modelAndView.addObject("allPayments", allPayments);

		// Set the view name
		modelAndView.setViewName("all_payments");

		return modelAndView;
	}

	@PostMapping("/updateStatus")
	public String updatePaymentStatus(@RequestParam("paymentId") Integer paymentId,
			@RequestParam("status") String status) {
		landlordDao.updatePaymentStatus(paymentId, status);
		return "redirect:/landlord/getAllPayments"; // Redirect to payments list
	}

	@GetMapping("/PropertyPage")
	public String showPropertiesPage(@RequestParam(value = "search", required = false) String search,
			@RequestParam(value = "location", required = false) String location,
			@RequestParam(value = "facilities", required = false) List<String> facilities, Model model,
			HttpSession session) {
		// Fetch properties based on search and filter criteria
		List<Property> properties = propertyDaoImpl.findProperties(search, location, facilities);

		// Fetch unique locations for the dropdown
		List<String> locations = propertyDaoImpl.findUniqueLocations();

		// Hardcode facilities for the checkbox
		List<String> availableFacilities = List.of("Parking", "Swimming Pool", "Gym", "Security System", "Internet",
				"Furnished", "Air Conditioning", "Elevator", "Garden");

		// Add properties and filters to the model
		model.addAttribute("properties", properties);
		model.addAttribute("locations", locations);
		model.addAttribute("facilities", availableFacilities);

		// Get logged-in user from session
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		model.addAttribute("loggedInUser", loggedInUser);

		return "viewProperties"; // property_page.jsp
	}

	@GetMapping("/PropertyDetails/{propertyId}")
	public String showPropertyDetails(@PathVariable int propertyId, @ModelAttribute("user") User user, Model model,
			HttpSession session, HttpServletRequest request) {
		Optional<Property> optionalProperty = propertyDaoImpl.findPropertyById(propertyId);
		User loggedInUser = (User) session.getAttribute("user");

		if (loggedInUser != null) {
			model.addAttribute("loggedInUser", loggedInUser);

			// Fetch property ID for the logged-in user
			Integer propertyID = propertyDaoImpl.findPropertyIdByUserId(loggedInUser.getUserId());

			// Add propertyID to the model
			model.addAttribute("propertyID", propertyID);
			request.setAttribute("propertyID", propertyID);

			System.out.println("Fetched Renting Property ID: " + propertyID);
		}

		if (optionalProperty.isPresent()) {
			model.addAttribute("property", optionalProperty.get());
			return "landlord_property"; // Assuming 'property_details.jsp'
		}

		return "redirect:/landlord/PropertyPage"; // Redirect if property not found
	}

	@GetMapping("deleteProperty/{propertyId}")
	public String deleteProperty(@PathVariable int propertyId, Model model) {
		Optional<Property> optionalProperty = propertyDaoImpl.findPropertyById(propertyId);
		model.addAttribute("propertyId", propertyId);

		if (optionalProperty.isPresent()) {
			model.addAttribute("property", optionalProperty.get());
			return "update_property"; // Assuming 'property_details.jsp'
		}

		return "update_property";
	}

	@PostMapping("/updateProperty/{propertyId}")
	public String updateProperty(@PathVariable int propertyId, @ModelAttribute("user") User user, @ModelAttribute Property property,
			 RedirectAttributes attributes, HttpSession session, Model model)
			throws IOException, SQLException {
		Optional<Property> optionalProperty = propertyDaoImpl.findPropertyById(propertyId);
		
		
		optionalProperty.get().setTitle(property.getTitle());
		optionalProperty.get().setDescription(property.getDescription());
		optionalProperty.get().setLocation(property.getLocation());
		optionalProperty.get().setPrice(property.getPrice());
		optionalProperty.get().setSwimmingPool(property.isSwimmingPool());
		optionalProperty.get().setGym(property.isGym());
		optionalProperty.get().setParking(property.isParking());
		optionalProperty.get().setGarden(property.isGarden());
		optionalProperty.get().setAirConditioning(property.isAirConditioning());
		optionalProperty.get().setElevator(property.isElevator());
		optionalProperty.get().setSecuritySystem(property.isSecuritySystem());
		optionalProperty.get().setInternet(property.isInternet());
		optionalProperty.get().setFurnished(property.isFurnished());
		
//		 if (!image.isEmpty()) {
//			 optionalProperty.get().setPropertyImage(image.getBytes());
//			 byte[] imageBytes = image.getBytes();
//			 String base64Image = Base64.getEncoder().encodeToString(imageBytes);
//			 model.addAttribute("propertyImage" ,base64Image);
//         }
//		
		return "redirect:/landlord/PropertyDetails/" + propertyId;

	}

	@GetMapping("/api/payment/details")
	public Map<String, Object> getPaymentDetails(@RequestParam("tenantId") Long tenantId) {
		Landlord landlord = landlordDao.getLandlordDetails();
		System.out.println(landlord);
		double amount = 12345.67; // Example amount, you should fetch this based on the tenantId
		Map<String, Object> response = new HashMap<>();
		response.put("bankDetails", landlord.getBankDetails());
		response.put("upiDetails", landlord.getUpiDetails());
		response.put("amount", amount);
		System.out.println(amount);
		return response;
	}

	@GetMapping("/openPropertyManagement")
	public String openPropertyManagement() {

		return "property_management";
	}

	@GetMapping("/openReports")
	public String openReports() {
		return "view_reports"; // JSP file name without extension
	}

	@GetMapping("/paymentManagement")
	public String paymentmanagement() {
		return "payment_management"; // JSP file name without extension
	}

	@GetMapping("/manageManagers")
	public String manageManagers() {
		return "manage_managers";
	}

	@GetMapping("/manageTenants")
	public String manageTenants() {
		return "manage_tenants"; // JSP file name without extension
	}

	@GetMapping("/addTenants")
	public String addTenants() {
		return "add_tenant"; // JSP file name without extension
	}

	@GetMapping("/deleteTenants")
	public String deleteTenants() {
		return "delete_tenant"; // JSP file name without extension
	}

	@GetMapping("/assignTechnician")
	public String assignTechnician() {
		return "assign_technician"; // JSP file name without extension
	}

	@GetMapping("/addTechnician")
	public String addTechnician() {
		return "add_technician"; // JSP file name without extension
	}
}
