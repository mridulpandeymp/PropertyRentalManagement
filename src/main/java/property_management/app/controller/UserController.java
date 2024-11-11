package property_management.app.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import property_management.app.dao.PropertyDao;
import property_management.app.dao.TenantDao;
import property_management.app.dao.UserDao;
import property_management.app.entities.Manager;
import property_management.app.entities.Role;
import property_management.app.entities.Tenant;
import property_management.app.entities.User;
import property_management.utility.Password;

@Controller
@RequestMapping("/user")
public class UserController {

	private User user;

	@Autowired
	UserDao userDao;
	
	
	@Autowired
	TenantDao tenantDao;

	@GetMapping("/openLoginPage")
	public String openLoginPage() {
		return "user_login";
	}

	@GetMapping("/openManagerRegistrationPage")
	public String openManagerRegistrationPage() {

		return "manager_registration";
	}

	@GetMapping("/openTenantRegistrationPage")
	public String openTenantRegistrationPage() {

		return "tenant_registration";
	}

	@PostMapping("/login")
	public String login(@RequestParam String username, @RequestParam String password,
			@RequestParam(required = false) String forgotPassword, HttpSession session, Model model,
			RedirectAttributes attributes) {

		System.out.println("\n login request data: " + username + ", " + password);
		 if ("true".equals(forgotPassword)) {
		        return "redirect:/user/forgotPassword"; // Redirect to forgot password page
		    }

		try {
			user = userDao.fetchUser(username);
			System.out.println(user);

			String pwdSalt = user.getPasswordSalt();
			String oldPwdHash = user.getPasswordHash();

			String newPassword = password + pwdSalt;
			String newPasswordHash = Password.generatePwdHash(newPassword);

			if (newPasswordHash.equals(oldPwdHash)) {
				session.setAttribute("user", user);
				session.setAttribute("loggedInUser", user);

				session.setAttribute("isLoggedIn", true);
				if (user.getStatus().equals("A")) {
					model.addAttribute("user", user);

					int roleId = user.getRole().getRoleId();
					if (roleId == 1) {
						return "redirect:/user/landlord_dashboard";
					} else if (roleId == 2) {
						return "redirect:/user/manager_dashboard";
					} else if (roleId == 3) {

						return "redirect:/user/tenantDashboard"; // Use redirect to the tenant controller
					}

				} else {
					attributes.addFlashAttribute("message", "You are not approved");

				}

			} else {
				attributes.addFlashAttribute("message", "Incorrect Password");
			}
		} catch (EmptyResultDataAccessException e) {
			attributes.addFlashAttribute("message", "Incorrect Username");
		}

		return "redirect:/user/openLoginPage";
	}
	
	
	@GetMapping("/forgotPassword")
    public String forgotPassword() {
        return "forgot_password"; // JSP page for entering email
    }
	
		  @PostMapping("/verify_email")
	public String verifyEmail(@RequestParam("email") String email,RedirectAttributes redirectAttributes,Model model) {
	    // Email format validation to accept only @gmail.com emails
	    String emailRegex = "^[\\w-\\.]+@gmail\\.com$";
	    
	    // Check email length
	    if (email.length() < 5 || email.length() > 25) {
	    	
	    	redirectAttributes.addFlashAttribute("error","Email must be between 5 and 25 characters");
	        //model.addAttribute("error", "Email must be between 5 and 25 characters.");
	        return "forgot_password"; // Stay on the same page with error message
	    }
 
	    if (!email.matches(emailRegex)) {
	    	redirectAttributes.addFlashAttribute("error", "Invalid email format. Please enter a valid Gmail address.");
	        //model.addAttribute("error", "Invalid email format. Please enter a valid Gmail address.");
	        return "forgot_password"; // Stay on the same page with error message
	    }
 
	    User user = userDao.findByEmail(email);
	   // System.out.println("Opening reset password page1");
	    
	    if ( user != null) {
	        model.addAttribute("email", email); // Pass email to next page
	        System.out.println("Opening reset password page");
	        return "reset_password"; // Redirect to the reset password page
	    }
	    
	    else {
	    	redirectAttributes.addFlashAttribute("message", "Email not found");
	       model.addAttribute("error", "Email not found. Please try again.");
	       
	        return "forgot_password"; // Stay on the same page with error message
	    }
	}
		  
	@GetMapping("/resetPassword")
	public String resetPassword(Model model) {
		
		if(model.containsAttribute("email")) {
			model.addAttribute("email",model.getAttribute("email"));
		}
		return "reset_password"; // JSP page for entering email }
	}
	
	
    @PostMapping("/resetpassword")
    public String resetPassword(
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            @RequestParam("email") String email,
            Model model,RedirectAttributes redirectAttributes ) {
 
    	
        // Validate passwords
        if (!newPassword.equals(confirmPassword)) {
        	//redirectAttributes.addFlashAttribute("error", "Passwords do not match");
        	//redirectAttributes.addFlashAttribute("email",email);
            model.addAttribute("error1", "Passwords do not match.");
            model.addAttribute("email", email); // Keep email in case of error
            return "reset_password";
        }
       
        else if (!isValidPassword(newPassword)) {
        	//redirectAttributes.addFlashAttribute("error1", "Invalid password. It should be 8-15 characters long without spaces.");
            model.addAttribute("error1", "Invalid password. It should be 8-15 characters long without spaces.");
            model.addAttribute("email", email); // Keep email in case of error
            return "reset_password"; // Return to reset password page with error
        }
 
        
 
        // Proceed with password reset
        String passwordSalt = Password.generatePwdSalt(10);
        String passwordHash = Password.generatePwdHash(newPassword + passwordSalt);
 
        // Update the password in the database
        int result = userDao.forgotUserPassword(email, passwordHash, passwordSalt);
        if (result > 0) {
        	
        	System.out.println("Password reset successful");
        	redirectAttributes.addFlashAttribute("message", "New Password set sucessfully!");
            //model.addAttribute("message", "New password set successfully.");
            return "user_login"; // Redirect to login page after success
        } else {
        	redirectAttributes.addFlashAttribute("error1", "error updating password. Please try again");
            //model.addAttribute("error1", "Error updating password. Please try again.");
            model.addAttribute("email", email); // Keep email in case of error
            return "reset_password"; // Return to reset password page with error
        }
    }
 
    
  
  private boolean isValidPassword(String password) {
	    // Regex patterns
	    String specialCharPattern = ".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*"; // At least one special character
	    String lowerCasePattern = ".*[a-z].*"; // At least one lowercase letter
	    String upperCasePattern = ".*[A-Z].*"; // At least one uppercase letter
 
	    return password != null
	        && password.length() >= 8
	        && password.length() <= 15
	        && !password.contains(" ")
	        && password.matches(specialCharPattern) // Check for special character
	        && password.matches(lowerCasePattern) // Check for lowercase letter
	        && password.matches(upperCasePattern); // Check for uppercase letter
	}
 
 
 

	@PostMapping("/tenantRegister")
	public String tenantRegister(@ModelAttribute User user, RedirectAttributes attributes)
			throws IOException, SerialException, SQLException {
		user.setRole(new Role(3));
		user.setStatus("A");

		System.out.println("\n user : " + user);

		// Password Encryption starts
		String passwordSalt = Password.generatePwdSalt(10);
		user.setPasswordSalt(passwordSalt);

		// temporary data => password+salt
		String newPassword = user.getPassword() + passwordSalt; // 1234rdvyjtftyf

		String passwordHash = Password.generatePwdHash(newPassword);
		user.setPasswordHash(passwordHash);
		// Password Encryption completes

		int result = userDao.insertUser(user);

		if (result > 0) {
			attributes.addFlashAttribute("message", "Registration Successful");
			return "redirect:/user/openLoginPage";
		} else {
			attributes.addFlashAttribute("message", "Registration Failed");
			return "redirect:/user/openRegistrationPage";
		}
	}

	@PostMapping("/managerRegister")
	public String managerRegister(@ModelAttribute User user, @ModelAttribute Manager manager,
			RedirectAttributes attributes) throws IOException, SerialException, SQLException {
		user.setRole(new Role(2));
		user.setStatus("P");

		System.out.println("\n user : " + user);

		// Password Encryption starts
		String passwordSalt = Password.generatePwdSalt(10);
		user.setPasswordSalt(passwordSalt);

		// temporary data => password+salt
		String newPassword = user.getPassword() + passwordSalt; // 1234rdvyjtftyf

		String passwordHash = Password.generatePwdHash(newPassword);
		user.setPasswordHash(passwordHash);
		// Password Encryption completes

		int result = userDao.insertManager(user, manager);

		if (result > 0) {
			attributes.addFlashAttribute("message", "Registration Successful");
			return "redirect:/user/openLoginPage";
		} else {
			attributes.addFlashAttribute("message", "Registration Failed");
			return "redirect:/user/openRegistrationPage";
		}

	}

	@GetMapping("/viewProfile")
	public String viewProfile(HttpSession session, Model model) throws IOException, SQLException {

		User sessionUser = (User) session.getAttribute("user"); // Retrieve user from session
		System.err.println(sessionUser);

		if (sessionUser == null) {
			model.addAttribute("errorMessage", "No user found in session.");
			return "error"; // Redirect to error page if no user in session
		}
		System.out.println("User Status: " + sessionUser.getStatus());

		// Convert profile image to Base64 if exists
		if (sessionUser.getProfileImage() != null && !sessionUser.getProfileImage().isEmpty()) {
			byte[] imageBytes = sessionUser.getProfileImage().getBytes();
			String base64Image = Base64.getEncoder().encodeToString(imageBytes);
			session.setAttribute("profileImage", base64Image);
			model.addAttribute("profileImage", base64Image);
		} else {
			model.addAttribute("profileImage", null);
		}

		if (sessionUser.getIdProof() != null && !sessionUser.getIdProof().isEmpty()) {

			byte[] imageBytes = sessionUser.getIdProof().getBytes();
			String base64Image = Base64.getEncoder().encodeToString(imageBytes);
			session.setAttribute("idProof", base64Image);
			model.addAttribute("idProof", base64Image);
		} else {
			model.addAttribute("idProof", null);
		}

		model.addAttribute("user", sessionUser); // Pass user data to the view
		return "profile"; // The JSP page to display the profile
	}

	// Show the update profile page with pre-filled data
	@GetMapping("/update")
	public String showUpdateProfilePage(HttpSession session, Model model) throws IOException {
		User sessionUser = (User) session.getAttribute("user"); // Retrieve user from session
		if (sessionUser == null) {
			model.addAttribute("errorMessage", "No user found in session.");
			return "error"; // Redirect to error page if no user in session
		}
		byte[] imageBytes = sessionUser.getProfileImage().getBytes();
		String base64Image = Base64.getEncoder().encodeToString(imageBytes);
		model.addAttribute("profileImage", base64Image);

		byte[] idImageBytes = sessionUser.getIdProof().getBytes();
		String idBase64Image = Base64.getEncoder().encodeToString(idImageBytes);
		model.addAttribute("idProof", idBase64Image);

		model.addAttribute("user", sessionUser); // Add the session user object to pre-fill the form
		return "updateProfile"; // JSP page to be displayed for updating profile
	}

	// Handle the update form submission
	@PostMapping("/update")
	public String updateUserProfile(@ModelAttribute("user") User user,
			@RequestParam("profileImage") MultipartFile profileImage, @RequestParam("idProof") MultipartFile idProof,
			HttpSession session, RedirectAttributes redirectAttributes)
			throws SerialException, IOException, SQLException {

		System.out.println("start" + profileImage);
		// Retrieve user from session
		User sessionUser = (User) session.getAttribute("user");
		if (sessionUser == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "No user found in session.");
			return "redirect:/user/viewProfile"; // Redirect to profile page if no user in session
		}

		// Update session user details
		sessionUser.setFirstName(user.getFirstName());
		sessionUser.setLastName(user.getLastName());
		sessionUser.setEmailId(user.getEmailId());
		sessionUser.setMobileNo(user.getMobileNo());
		sessionUser.setUsername(user.getUsername());
		sessionUser.setDateOfBirth(user.getDateOfBirth());
		sessionUser.setUsername(user.getUsername());
		sessionUser.setStatus(user.getStatus());

		// If a new profile image is uploaded, set it to the session user
		if (profileImage != null && !profileImage.isEmpty()) {
			sessionUser.setProfileImage(profileImage);
			byte[] imageBytes = profileImage.getBytes();
			String base64Image = Base64.getEncoder().encodeToString(imageBytes);
			session.setAttribute("profileImage", base64Image);
		}

		if (idProof != null && !idProof.isEmpty()) {
			sessionUser.setIdProof(idProof);
			byte[] imageBytes = idProof.getBytes();
			String base64Image = Base64.getEncoder().encodeToString(imageBytes);
			session.setAttribute("idProof", base64Image);
		}

		// Update the user in the database
		boolean isUpdated = userDao.updateUser(sessionUser);
		if (isUpdated) {
			// Update session with the new user details
			session.setAttribute("user", sessionUser); // Update session user after successful DB update
			redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");
		} else {
			redirectAttributes.addFlashAttribute("errorMessage", "Failed to update profile.");
		}

		return "redirect:/user/viewProfile"; // Redirect to view profile after update
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "user_login"; // JSP file name without extension
	}

	private final PropertyDao propertyDao;

	@Autowired
	public UserController(PropertyDao propertyDao) {
		this.propertyDao = propertyDao;
	}

	@GetMapping("/tenantDashboard")
	public String tenantDashboard(@ModelAttribute("user") User user, Model model, HttpSession session,
			HttpServletRequest request) {
		User loggedInUser = (User) session.getAttribute("user");
		if (loggedInUser != null) {
			model.addAttribute("loggedInUser", loggedInUser);

			// Log the User ID
			System.out.println("Logged in User ID: " + loggedInUser.getUserId());

			// Fetch property ID for the logged-in user
			Integer propertyId = propertyDao.findPropertyIdByUserId(loggedInUser.getUserId());
			System.out.println("Fetched Property ID: " + propertyId);

			// Fetch tenant data
			Tenant tenant = tenantDao.getTenantByUserId(loggedInUser.getUserId());
			if (tenant != null) {
				String status = tenant.getTenantStatus();
				model.addAttribute("status", status);
				model.addAttribute("propertyId", propertyId);

				// Log tenant status
				System.out.println("Fetched Tenant Status: " + status);
				request.setAttribute("status", status);
			} else {
				System.out.println("No tenant data found for User ID: " + loggedInUser.getUserId());
				model.addAttribute("status", "No tenant data found.");
				// Optionally handle this case (e.g., redirect or show a message)
			}
		} else {
			System.out.println("User is not logged in.");
		}
		return "tenant_dashboard"; // Your JSP page
	}
	
	@GetMapping("/landlord_dashboard")
	public String openLandlordDashboard() {
		return "landlord_dashboard";
	}
	
	@GetMapping("/manager_dashboard")
	public String openManagerDashboard() {
		return "manager_dashboard";
	}
	


}
