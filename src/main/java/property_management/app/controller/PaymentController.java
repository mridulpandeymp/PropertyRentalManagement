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
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import property_management.app.entities.Landlord;

import property_management.app.entities.Payment;
import property_management.app.entities.User;
import property_management.app.dao.*;

import java.time.LocalDate;

import java.util.List;

import java.util.Optional;

@Controller

public class PaymentController {

	@Autowired
	private PaymentDao paymentDao;

	@Autowired
	private LandlordDao landlordDao;

	@Autowired
	private PropertyDao propertyDao;

	@Autowired
	private MaintenanceRequestDao maintenanceRequestDao;

	@GetMapping("/getAssignedPayments")
	public ModelAndView getAssignedPayments(HttpSession session) {
		User loggedInUser = (User) session.getAttribute("user");
		System.out.println("logged user:" + loggedInUser);

		Optional<Integer> managerIdOptional = maintenanceRequestDao.findManagerIdByUserId(loggedInUser.getUserId());
		System.out.println("manager id :" + managerIdOptional);

		ModelAndView modelAndView = new ModelAndView();

		if (managerIdOptional.isPresent()) {
			Integer managerId = managerIdOptional.get();
			System.out.println("manager id :" + managerId);

			List<Payment> assignedPayments = paymentDao.getAssignedPayments(managerId);
			System.out.println("assignedPayments :" + assignedPayments);

			// Set the assigned payments in the ModelAndView
			modelAndView.addObject("assignedPayments", assignedPayments);

			// Set the view name
			modelAndView.setViewName("payment_management");
		} else {
			modelAndView.addObject("errorMessage", "Manager not found for this user.");
			modelAndView.setViewName("error_page"); // Change to an appropriate error view
		}

		return modelAndView;
	}

	@PostMapping("/updateStatus")
	public String updatePaymentStatus(@RequestParam("paymentId") Integer paymentId,
			@RequestParam("status") String status) {
		// ModelAndView modelAndView = new ModelAndView();
		// Set the view name
		// modelAndView.setViewName("payment_management");
		paymentDao.updatePaymentStatus(paymentId, status);
		return "redirect:/getAssignedPayments"; // Redirect to payments list
	}

	@GetMapping("/user/payment_page")

	public String getPayments(HttpServletRequest request, Model model) {

		// Assuming you already have the managerId from session or request

		Long managerId = (Long) request.getSession().getAttribute("managerId");

		// Fetch payments for the manager

		List<Payment> payments = paymentDao.getPaymentsByManager(managerId);

		// Add payments to request attribute

		request.setAttribute("payments", payments);

		// Return the JSP page

		return "payment_page"; // This maps to the JSP page "payment_page.jsp"

	}

	@GetMapping("/api/payment/details")

	public ResponseEntity<Payment> getPaymentDetails(@RequestParam("tenantId") Long tenantId) {

		Landlord landlord = landlordDao.getLandlordDetails();

		if (landlord == null) {

			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);

		}

		// Fetch amount from the property table (Assuming you have a method for this)

		double amount = propertyDao.getAmountByTenantId(tenantId); // This method should be implemented in your

		// PropertyDAO

		// Create the PaymentDetails model

		Payment paymentDetails = new Payment();

		paymentDetails.setBankDetails(landlord.getBankDetails());

		paymentDetails.setUpiDetails(landlord.getUpiDetails());

		paymentDetails.setAmount(amount);

		return ResponseEntity.ok(paymentDetails);

	}

	@PostMapping("/api/payment/submit")

	public ResponseEntity<String> submitPayment(@RequestParam("tenantId") Long tenantId,

			@RequestParam("payment_method") String paymentMethod,

			@RequestParam("amount") String amountStr,

			@RequestParam(value = "receipt", required = false) MultipartFile receipt) {

		try {

			// Retrieve manager ID based on tenantId

			Long managerId = (long) 1; // Adjust this method based on your
																				// service layer

			// Validate input parameters

			if (tenantId == null || amountStr == null || paymentMethod == null || managerId == null) {

				return ResponseEntity.badRequest().body("Required fields are missing.");

			}

			// Trim and validate payment method length

			paymentMethod = paymentMethod.trim();

			if (paymentMethod.length() > 50) {

				return ResponseEntity.badRequest().body("Payment method exceeds maximum length.");

			}

			// Convert amount to Double

			Double amount;

			try {

				amount = Double.valueOf(amountStr);

			} catch (NumberFormatException e) {

				return ResponseEntity.badRequest().body("Invalid amount format.");

			}

			// Create payment object

			Payment payment = new Payment();

			payment.setTenantId(tenantId);

			payment.setPaymentMethod(paymentMethod);

			payment.setPrice(amount);

			payment.setPaymentDate(LocalDate.now());

			payment.setManagerId(managerId);

			if (receipt != null && !receipt.isEmpty()) {

				byte[] receiptBytes = receipt.getBytes();

				payment.setReceipt(receiptBytes);

			}

			paymentDao.savePayment(payment);

			return ResponseEntity.ok("Payment submitted successfully!");

		} catch (Exception e) {

			e.printStackTrace();

			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)

					.body("Failed to submit payment: " + e.getMessage());

		}

	}

}
