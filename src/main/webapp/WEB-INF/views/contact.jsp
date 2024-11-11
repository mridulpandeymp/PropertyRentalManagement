<%@page import="property_management.app.entities.User"%>
 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestyle.css">
    
    <style type="text/css">
    	* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
		}
		
		body {
		    font-family: 'Arial', sans-serif;
		    background-image: url('https://wallpaperaccess.com/full/3124535.jpg'); /* Replace with your background image */
		    background-size: cover;
		    background-position: center;
		    color: #fff;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    height: 100vh;
		    position: relative;
		}
		
		.container {
		    text-align: center;
		    backdrop-filter: blur(5px);
		    padding: 20px;
		    border-radius: 15px;
		    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
		}
		
		h1 {
		    margin-bottom: 20px;
		    font-size: 3rem;
		    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);\
		    color: #ffcc00; /* Light yellow for better contrast */
		    
		}
		
		.card-container {
		    display: flex;
		    justify-content: center;
		    flex-wrap: wrap;
		    gap: 20px;
		}
		
		.card {
		    background: linear-gradient(145deg, rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.1));
		    border-radius: 15px;
		    padding: 20px;
		    width: 280px;
		    transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
		    text-align: left;
		    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
		    position: relative;
		    overflow: hidden;
		}
		
		.card::before {
		    content: "";
		    position: absolute;
		    top: -10%;
		    left: -10%;
		    right: -10%;
		    bottom: -10%;
		    background: rgba(255, 255, 255, 0.2);
		    border-radius: 15px;
		    filter: blur(15px);
		    z-index: 0;
		    transition: all 0.4s ease;
		}
		
		.card:hover::before {
		    filter: blur(30px);
		}
		
		.card:hover {
		    transform: translateY(-10px);
		    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.7);
		}
		
		.card h2 {
		    font-size: 1.5rem;
		    margin-bottom: 10px;
		    z-index: 1;
		    position: relative;
		    color: #ffcc00; /* Light yellow for headings in cards */
		    
		}
		
		.card p {
		    font-size: 1rem;
		    z-index: 1;
		    position: relative;
		    color: #ffffff; /* White for paragraph text in cards */
		    
		}
		
		@media (max-width: 600px) {
		    .card-container {
		        flex-direction: column;
		        align-items: center;
		    }
		
		    .card {
		        width: 90%;
		    }
		
		    h1 {
		        font-size: 2.5rem;
		    }
		}
		
		
/* Ensure html and body take full height */
html, body {
    height: 100%;
    display: flex;
    flex-direction: column;
}
 
/* Make the container flexible */
.container {
    flex: 1; /* Allow the container to grow */
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 20px;
    max-width: 800px; /* Set a maximum width for fixed-size content */
    margin-top: 300px;
    margin-bottom: 50px;
}
 
/* Footer styles */
.footer {
    color: white;
    background-color: #2b250e;
    padding: 40px 0;
    margin-top: 10px; /* Adjust space above footer */
    width: 100%; /* Ensure the footer spans the full width */
}
 
    	
    </style>
    
</head>
<body>
 
	<%
 
	// Check if the user is logged in
	User loggedInUser = (User) session.getAttribute("loggedInUser");
	
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
				<li class="dropdown"><a href="#" class="dropbtn"><%=loggedInUser.getFirstName()%></a>
					<div class="udropdown-content">
						<a href="/user/<%=roleDashboard%>">Dashboard</a> <a
							href="/user/viewProfile">View Profile</a> <a href="/user/logout">Logout</a>
					</div></li>
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
 
    <div class="container">
        <h1>Contact Us</h1>
        <div class="card-container">
            <div class="card">
                <h2>Email Us</h2>
                <p>support@example.com</p>
            </div>
            <div class="card">
                <h2>Call Us</h2>
                <p>+1 234 567 890</p>
            </div>
            <div class="card">
                <h2>Visit Us</h2>
                <p>123 Example St, City, Country</p>
            </div>
            <div class="card">
                <h2>Follow Us</h2>
                <p>@example on social media</p>
            </div>
        </div>
    </div>
 
 
		<!-- Footer Section -->
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
 
 