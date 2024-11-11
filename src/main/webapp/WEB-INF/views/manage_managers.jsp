 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Managers</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/homestyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<style type="text/css">
		/* General Content Styling */
		
.content {
    max-width: 1200px;
    margin: 20px auto;
    padding: 20px;
    background: rgba(255, 255, 255, 0.2); /* Semi-transparent white background */
    border-radius: 8px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    margin-top: 120px;
    margin-bottom: 70px;
    min-height: 300px;
    min-width: 700px;
}
 
/* Headings */
.content h1 {
    font-size: 2.5rem;
    color: #000000;
    text-align: center;
    margin-bottom: 20px;
    font-weight: 700;
    text-transform: uppercase;
}
 
/* Button Container */
.content div {
    display: flex;
    justify-content: center;
    gap: 20px; /* Space between buttons */
}
 
/* Button Styling */
button {
    background-color: #000000; /* Bootstrap Primary Color */
    color: white;
    border: none;
    border-radius: 5px;
    padding: 12px 20px;
    font-size: 1rem;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
}
 
/* Button Hover Effects */
button:hover {
    background-color: #0056b3; /* Darker shade on hover */
    transform: translateY(-2px); /* Slight lift effect */
}
 
/* Responsive Design */
@media (max-width: 768px) {
    .content {
        padding: 15px;
    }
    
    .content h1 {
        font-size: 2rem;
    }
    
    button {
        padding: 10px 15px;
        font-size: 0.9rem;
    }
}
		
	</style>
	
	</head>
<body style="background-image: url('https://wallpaperaccess.com/full/1657789.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
 
	<%@include file="header.jsp"%>
	
	<div class="content">
    <h1>Manage Managers</h1>
    <div>
        <form action="${pageContext.request.contextPath}/approveRejectManagers" method="GET">
            <button type="submit">Approve/Reject Managers</button>
        </form>
        <form action="${pageContext.request.contextPath}/assignManagers" method="GET">
            <button type="submit">Assign Managers</button>
        </form>
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
 
 
 