<%@ page import="java.util.Date" %>
<%@ page import="property_management.app.entities.LeaseAgreement" %>
<%@page import="property_management.app.entities.User"%>


<%
    LeaseAgreement lease = (LeaseAgreement) request.getAttribute("leaseAgreement");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lease Agreement Details</title>
    <link href="${pageContext.request.contextPath}/css/homestyle.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Georgia', serif;
            background-color: #f0f0f0;
            margin-top: 70px;
        }
        .lease-agreement-card {
            background-color: #ffffff;
            border: 1px solid #dddddd;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
            padding: 30px;
            width: 80%;
            max-width: 800px;
            margin: 20px auto; /* Centering the card */
            position: relative;
            overflow: hidden;
            border-top: 5px solid #4CAF50; /* Green accent */
        }
        .lease-agreement-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
            text-align: center;
            color: #333333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 5px;
        }
        .lease-agreement-content {
            line-height: 1.6;
            font-size: 16px;
            color: #555555;
            margin-bottom: 15px;
        }
        h4 {
            font-size: 20px;
            color: #4CAF50;
            margin-top: 20px;
        }
        .back-button-container {
            text-align: center;
            margin: 20px 0;
        }
        .back-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>



 	 <!-- Check for user session and cache control -->
    <%
        // Cache control
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies.

        // Check if the user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            response.sendRedirect("/user/openLoginPage");
            return; // Stop processing the rest of the page
        }
    %>
 

	<!-- Constant Navigation Bar -->
	<nav class="navbar">
		<div class="navbar-container">
			<a href="#" class="logo">Property Management</a>
			<ul class="nav-links">
				<li><a href="/">Home</a></li>
				<li><a href="/property/PropertyPage">Properties</a></li>
				<li><a href="/aboutUs">About Us</a></li>
				<li><a href="/contact">Contact</a></li>
							
			<%
			if (loggedInUser != null) {
				String roleDashboard = "";
				int roleId = loggedInUser.getRole().getRoleId();
				if (roleId == 1) {
					roleDashboard = "landlord_dashboard";
				} else if (roleId == 2) {
					roleDashboard = "manager_dashboard";
				} else if (roleId == 3) {
					roleDashboard = "tenantDashboard";
				}
			%>
				<li class="dropdown">
					<a href="#" class="dropbtn"><%= loggedInUser.getFirstName() %></a>
					<div class="udropdown-content">
						<a href="/user/<%= roleDashboard %>">Dashboard</a>
						<a href="/user/viewProfile">View Profile</a>
						<a href="/user/logout">Logout</a>
					</div>
				</li>
			<%
			} else {
			%>
				<li><a href="/user/openLoginPage" class="login-btn">Login</a></li>
			<%
			}
			%>
			</ul>
		</div>
	</nav>

    <div class="content">
        <div class="back-button-container">
            <a href="<%= request.getContextPath() + "/lease-agreements/myLeaseAgreements" %>" class="back-button">← Back to Lease Agreements</a>
        </div>

        <section class="lease-agreement-details">
            <div class="lease-agreement-card">
                <div class="lease-agreement-title">Lease Agreement</div>
                <div class="lease-agreement-content">
                    <p>
                        This Lease Agreement is made on this <strong><%= new Date() %></strong> between the Landlord and the Tenant. The following terms and conditions shall apply:
                    </p>

                    <h4>1. Lease ID</h4>
                    <p>
                        The lease ID is <strong><%= lease.getLeaseId() %></strong>.
                    </p>

                    <h4>2. Duration of Lease</h4>
                    <p>
                        The lease term will commence on <strong><%= lease.getLeaseStartDate() %></strong> and will terminate on <strong><%= lease.getLeaseEndDate() %></strong>. It is important for both parties to adhere to this timeframe, as any failure to do so may result in penalties or legal actions.
                    </p>

                    <h4>3. Rent Payment</h4>
                    <p>
                        The monthly rent for the premises shall be <strong><%= lease.getRentAmount() %></strong>. Rent is due on the first day of each month. Late payments may incur additional fees as specified in the lease agreement.
                    </p>

                    <h4>4. Security Deposit</h4>
                    <p>
                        The Tenant shall pay a security deposit of <strong><%= lease.getSecurityDeposit() %></strong> prior to moving into the premises. This deposit will cover any damages or unpaid rent at the end of the lease term. The Landlord must return the deposit within 30 days of lease termination, minus any deductions for damages.
                    </p>

                    <h4>5. Maintenance Responsibilities</h4>
                    <p>
                        The Tenant is responsible for maintaining the premises in good condition. This includes keeping all fixtures and appliances in working order. The Tenant must report any maintenance issues to the Landlord promptly to prevent further damage.
                    </p>

                    <h4>6. Rules and Regulations</h4>
                    <p>
                        The Tenant agrees to comply with all community rules and regulations as established by the Landlord. This includes but is not limited to noise restrictions, waste disposal guidelines, and pet policies. Failure to adhere to these rules may result in termination of the lease.
                    </p>

                    <h4>7. Alterations and Modifications</h4>
                    <p>
                        The Tenant shall not make any alterations or modifications to the premises without the prior written consent of the Landlord. This includes painting, installing fixtures, or making any structural changes. Unauthorized modifications may result in charges for restoration to the original condition.
                    </p>

                    <h4>8. Termination of Lease</h4>
                    <p>
                        Either party may terminate the lease agreement by providing written notice at least 30 days before the intended termination date. Early termination by the Tenant may incur penalties, and the Tenant may be responsible for rent until a new tenant is secured.
                    </p>

                    <h4>9. Dispute Resolution</h4>
                    <p>
                        In the event of a dispute arising from this lease agreement, both parties agree to seek mediation before pursuing legal action. This process is intended to resolve conflicts amicably and efficiently.
                    </p>

                    <h4>10. Governing Law</h4>
                    <p>
                        This lease agreement shall be governed by and construed in accordance with the laws of the state in which the property is located. Any legal actions must be brought in the appropriate court of that jurisdiction.
                    </p>

                    <div class="signatures">
                        <p class="landlord-signature">
                            __________________________<br>Landlord Signature
                        </p>
                        <p class="tenant-signature">
                            __________________________<br>Tenant Signature
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <footer class="footer">
        <div class="footer-content">
            <div class="footer-left">
                <h3>Property Management</h3>
                <p>Your one-stop solution for managing and finding properties.</p>
            </div>
            <div class="footer-right">
                <ul class="social-icons">
                    <li><a href="#"><i class="fab fa-facebook"></i></a></li>
                    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                    <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                    <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 Property Management System. All Rights Reserved.</p>
        </div>
    </footer>

</body>
</html>
