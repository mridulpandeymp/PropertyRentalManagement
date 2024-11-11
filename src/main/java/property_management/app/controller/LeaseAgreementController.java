package property_management.app.controller;

import property_management.app.entities.LeaseAgreement;
import property_management.app.entities.User;
import property_management.app.dao.LeaseAgreementDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

import java.util.List;

@Controller
@RequestMapping("/lease-agreements")
public class LeaseAgreementController {

    @Autowired
    private LeaseAgreementDao leaseAgreementDao;

    @GetMapping
    public String listLeaseAgreements(Model model) {
        List<LeaseAgreement> leaseAgreements = leaseAgreementDao.getAllLeaseAgreements();
        System.out.println("Lease Agreements: " + leaseAgreements); // Log the list
        model.addAttribute("leaseAgreements", leaseAgreements);
        return "lease_agreements"; // Returns the JSP page name
    }


    @GetMapping("/{id}")
    public String getLeaseAgreementDetail(@PathVariable int id, Model model) {
        LeaseAgreement leaseAgreement = leaseAgreementDao.getLeaseAgreementById(id);
        model.addAttribute("leaseAgreement", leaseAgreement);
        return "lease_agreement_detail"; // Returns the JSP detail page name
    }
    
    // Get lease agreements by user ID
   
    // Get lease agreements by user ID (logged-in user)
    @GetMapping("/myLeaseAgreements")
    public String listLeaseAgreementsByUserId(@ModelAttribute("user") User user, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("user"); // Get logged-in user from session
        if (loggedInUser != null) {
            List<LeaseAgreement> leaseAgreements = leaseAgreementDao.getLeaseAgreementsByUserId(loggedInUser.getUserId());

            System.out.println("Fetched Lease Agreements: " + leaseAgreements);
            
            if (leaseAgreements == null || leaseAgreements.isEmpty()) {
                System.out.println("No lease agreements found for User ID " + loggedInUser.getUserId());
            } else {
                System.out.println("Lease Agreements for User ID " + loggedInUser.getUserId() + ":");
                for (LeaseAgreement lease : leaseAgreements) {
                    System.out.println("Lease ID: " + lease.getLeaseId() +
                                       ", Tenant ID: " + lease.getTenantId() +
                                       ", Property ID: " + lease.getPropertyId() +
                                       ", Lease Start Date: " + lease.getLeaseStartDate() +
                                       ", Lease End Date: " + lease.getLeaseEndDate() +
                                       ", Rent Amount: " + lease.getRentAmount() +
                                       ", Deposit Amount: " + lease.getSecurityDeposit() +
//                                       ", Payment Schedule: " + lease.getPaymentSchedule() +
                                       ", Agreement Details: " + lease.getAgreementDetails());
                }
            }

            model.addAttribute("leaseAgreements", leaseAgreements);
        } else {
            model.addAttribute("errorMessage", "User not logged in.");
            return "redirect:/user/openLoginPage"; // Redirect to the login page
        }

        return "lease_agreements"; // Returns the JSP page name
    }


    
}
