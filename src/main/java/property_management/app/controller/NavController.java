package property_management.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

import property_management.app.dao.PropertyDao;
import property_management.app.entities.Property;
import property_management.app.entities.User;

@Controller
public class NavController {

	private final PropertyDao propertyDao;

	@Autowired
	public NavController(PropertyDao propertyDao) {
		this.propertyDao = propertyDao;
	}

	@GetMapping("/")
	public String showHomePage(@ModelAttribute("user") User user,Model model, HttpSession session) {
	    List<Property> latestProperties = propertyDao.getLatestProperties();
	    model.addAttribute("latestProperties", latestProperties);
	    
	    // Pass logged-in user data to the view
	    User loggedInUser = (User) session.getAttribute("user");
	    model.addAttribute("loggedInUser", loggedInUser);
	    
	    return "home";
	}


	@GetMapping("/aboutUs")
	public String openAboutPage() {
		return "about_us";
	}
	
	@GetMapping("/contact")
	public String openContact() {
		return "contact";
	}
 

}
