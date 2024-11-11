
<%@page import="org.springframework.web.multipart.MultipartFile"%>
<%@page import="property_management.app.entities.Property"%>
<%@page import="property_management.app.entities.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Property Management System - Home</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">



<style>

/* Style for carousel container */
.carousel {
	position: relative;
	display: flex;
	align-items: center;
	overflow: hidden;
	width: 100%;
}

/* Wrapper for the cards */
.cards-wrapper {
	display: flex;
	flex-wrap: nowrap;
	overflow-x: auto;
	scroll-behavior: smooth;
	-webkit-overflow-scrolling: touch;
	scrollbar-width: none; /* Hide scrollbar in Firefox */
}

.cards-wrapper::-webkit-scrollbar {
	display: none; /* Hide scrollbar in Chrome, Safari, and Opera */
}

/* Each card styling */
.cards {
	display: flex;
	flex-wrap: nowrap;
}

.card {
	min-width: 300px; /* Adjust the width of each card */
	margin: 10px;
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #fff;
	flex-shrink: 0; /* Prevent the card from shrinking */
	scroll-snap-align: start; /* Snap cards to the scroll */
}

/* Arrow buttons */
.arrow {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: rgba(0, 0, 0, 0.5);
	color: white;
	border: none;
	padding: 10px;
	cursor: pointer;
	z-index: 1;
}

.left-arrow {
	left: 10px;
}

.right-arrow {
	right: 10px;
}

	
	/* Dropdown styling */
.dropdown {
    position: relative;
    display: inline-block;
}

.dropbtn {
    background-color: #333;
    color: white;
    padding: 10px;
    border: none;
    cursor: pointer;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover { background-color: #ddd; }

.dropdown:hover .dropdown-content { display: block; }
	

/* Style for carousel container */
.carousel {
	position: relative;
	display: flex;
	align-items: center;
	overflow: hidden;
	width: 100%;
}

/* Wrapper for the cards */
.cards-wrapper {
	display: flex;
	flex-wrap: nowrap;
	overflow-x: auto;
	scroll-behavior: smooth;
	-webkit-overflow-scrolling: touch;
	scrollbar-width: none; /* Hide scrollbar in Firefox */
}

.cards-wrapper::-webkit-scrollbar {
	display: none; /* Hide scrollbar in Chrome, Safari, and Opera */
}

/* Each card styling */
.cards {
	display: flex;
	flex-wrap: nowrap;
}

.card {
	min-width: 300px; /* Adjust the width of each card */
	margin: 10px;
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #fff;
	flex-shrink: 0; /* Prevent the card from shrinking */
	scroll-snap-align: start; /* Snap cards to the scroll */
}

/* Arrow buttons */
.arrow {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: rgba(0, 0, 0, 0.5);
	color: white;
	border: none;
	padding: 10px;
	cursor: pointer;
	z-index: 1;
}

.left-arrow {
	left: 10px;
}

.right-arrow {
	right: 10px;
}
</style>
</head>
<body>

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
			User loggedInUser = (User) session.getAttribute("loggedInUser");
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
		<!-- Banner Section with Poster -->
		<section class="banner"
			style="background-image: url('https://images5.alphacoders.com/647/thumb-1920-647570.jpg');">

			<div class="banner-content">
				<h1>Find Your Dream Property</h1>
				<p>Search from a wide range of properties that suit your
					preferences and budget.</p>
				<a href="/property/PropertyPage" class="btn-primary">Explore Properties</a>
			</div>
		</section>

		<!-- Cards Section: Property Listings or Features -->
		<section class="cards-container">
			<div class="cards-header">
				<h2>Featured Properties</h2>
				<a href="/property/PropertyPage" class="see-all-link">See All</a>
			</div>
			<div class="carousel">
				<button class="arrow left-arrow" id="leftArrow">&#10094;</button>
				<div class="cards-wrapper" id="propertyCards">
					<div class="cards">
						<!-- Fetch properties dynamically from backend -->
						<%
						List<Property> latestProperties = (List<Property>) request.getAttribute("latestProperties");
						if (latestProperties != null && !latestProperties.isEmpty()) {
							for (Property property : latestProperties) {
								byte[] imageBlob = property.getpropertyImage(); // Get the image blob
						%>
						<div class="card">
							<%
							if (imageBlob != null) {
							%>
							<img
								src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(imageBlob)%>"
								alt="Property Image">
							<%
							} else { // Fallback to a default image if no image is available
							%>
							<img src="/images/default-placeholder.png" alt="Default Image">
							<%
							}
							%>
							<h3><%=property.getTitle()%></h3>
							<p><%=property.getDescription()%></p>
							<!-- Property Details Button -->
							<a
								href="${pageContext.request.contextPath}/property/PropertyDetails/<%= property.getPropertyId() %>"
								class="btn-secondary">View Details</a>
						</div>
						<%
						}
						} else {
						%>
						<p>No properties available at the moment.</p>
						<%
						}
						%>

					</div>
				</div>
				<button class="arrow right-arrow" id="rightArrow">&#10095;</button>
			</div>
		</section>


		<!-- New Section: Our Services -->
		<section class="cards-container services-section">
			<div class="cards-title">
				<h2>Our Services</h2>
			</div>
			<div class="cards">
				<!-- Service 1 -->
				<div class="card">
					<i class="fas fa-home fa-3x"></i>
					<h3>Rental Property Listings</h3>
					<p>Browse a wide selection of available rental properties
						tailored to your needs.</p>
				</div>
				<!-- Service 2 -->
				<div class="card">
					<i class="fas fa-handshake fa-3x"></i>
					<h3>Tenant Support</h3>
					<p>Personalized assistance for tenants throughout the rental
						process.</p>
				</div>
				<!-- Service 3 -->
				<div class="card">
					<i class="fas fa-key fa-3x"></i>
					<h3>Lease Agreement Assistance</h3>
					<p>Guidance and support in reviewing and signing lease
						agreements.</p>
				</div>
			</div>
		</section>

		<!-- New Section: Testimonials -->
		<section class="cards-container testimonials-section">
			<div class="cards-title">
				<h2>Testimonials</h2>
			</div>
			<div class="cards">
				<!-- Testimonial 1 -->
				<div class="card testimonial-card">
					<p>"Property Management helped me find the perfect apartment in
						the city. Highly recommended!"</p>
					<h4>- John Doe</h4>
				</div>
				<!-- Testimonial 2 -->
				<div class="card testimonial-card">
					<p>"The team provided excellent support throughout the
						home-buying process. Couldn't be happier!"</p>
					<h4>- Jane Smith</h4>
				</div>
				<!-- Testimonial 3 -->
				<div class="card testimonial-card">
					<p>"I found a beautiful vacation home thanks to Property
						Management. Their service is outstanding!"</p>
					<h4>- Robert Brown</h4>
				</div>
			</div>
		</section>
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



	<script>
		    const leftArrow = document.getElementById('leftArrow');
		    const rightArrow = document.getElementById('rightArrow');
		    const propertyCards = document.getElementById('propertyCards');

		    leftArrow.addEventListener('click', () => {
		        propertyCards.scrollBy({
		            left: -300,  // Adjust this value based on card width
		            behavior: 'smooth'
		        });
		    });

		    rightArrow.addEventListener('click', () => {
		        propertyCards.scrollBy({
		            left: 300,  // Adjust this value based on card width
		            behavior: 'smooth'
		        });
		    });
		</script>

</body>
</html>

