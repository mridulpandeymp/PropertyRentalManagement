<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Registration Page</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestyle.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
 
    <title>Maintenance Request Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            width: 50%;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 80px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        select, textarea, input[type="file"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            width: 48%;
            padding: 10px;
            border: none;
            background-color: #5cb85c;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #4cae4c;
        }
        .btn-back {
            background-color: #d9534f;
            float: right;
        }
        .progress-bar {
            display: none;
            width: 100%;
            background-color: #f3f3f3;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .progress {
            width: 0%;
            height: 10px;
            background-color: #5cb85c;
            border-radius: 5px;
        }
        .request {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
 
<%@include file="header.jsp" %>
 
 
    <div class="container">
        <h2>Maintenance Request Form</h2>
        <form action="/api/maintenance/submit" method="post" enctype="multipart/form-data" onsubmit="return handleSubmit(event)">
            <input type="hidden" name="tenantId" value="1" />
            <label for="request_type">Request Type</label>
            <select id="request_type" name="request_type" required>
                <option value="Plumbing">Plumbing</option>
                <option value="Electrical">Electrical</option>
                <option value="Heating/Cooling">Heating/Cooling</option>
                <option value="Other">Other</option>
            </select>
            <label for="description">Description</label>
            <textarea id="description" name="description" rows="4" required></textarea>
            <label for="photo">Upload Photo (Optional)</label>
            <input type="file" id="photo" name="photo" accept="image/*">
            <div class="progress-bar">
                <div class="progress"></div>
            </div>
            <button type="submit">Submit Request</button>
            <button type="button" class="btn-back" onclick="window.location.href='/user/maintenanceRequest';">Back to Dashboard</button>
        </form>
 
<!--        <h2>Previous Maintenance Requests</h2>
        <div id="previous-requests"></div> -->
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
        function handleSubmit(event) {
            event.preventDefault(); // Prevents the default form submission
 
            const form = event.target;
            const formData = new FormData(form);
            const photoInput = document.getElementById('photo');
 
            // Client-side validation for file size (limit to 5 MB)
            const maxSize = 5 * 1024 * 1024; // 5 MB
            if (photoInput.files.length > 0) {
                const file = photoInput.files[0];
                if (file.size > maxSize) {
                    alert('File size exceeds 5 MB limit. Please upload a smaller file.');
                    return false;
                }
                if (!file.type.startsWith('image/')) {
                    alert('Only image files are allowed.');
                    return false;
                }
            }
 
            const progressBar = document.querySelector('.progress-bar');
            const progress = document.querySelector('.progress');
            progressBar.style.display = 'block'; // Show progress bar
 
            // Fetch API for form submission
            fetch(form.action, {
                method: form.method,
                body: formData
            }).then(response => {
                if (response.ok) {
                    alert('Request is submitted successfully!');
                    window.location.reload(); // Reloads the page after submission
                } else {
                    alert('Failed to submit the request. Please try again.');
                }
            }).catch(error => {
                console.error('Error:', error);
                alert('There was an error submitting the request.');
            }).finally(() => {
                progressBar.style.display = 'none'; // Hide progress bar when finished
            });
            return false; // Prevent traditional form submission
        }
 
		<script>
			document.addEventListener("DOMContentLoaded", function() {
			    const tenantId = 1; // Replace with the actual tenant ID
			    fetch(`/api/maintenance/requests/1`)
			        .then(response => response.json())
			        .then(data => {
			            const requestsDiv = document.getElementById('previous-requests');
			            requestsDiv.innerHTML = ''; // Clear previous content
 
			            if (data.length === 0) {
			                requestsDiv.innerHTML = '<p>No previous requests found.</p>';
			            } else {
			                data.forEach(request => {
			                    const requestDiv = document.createElement('div');
			                    requestDiv.className = 'request';
			                    requestDiv.innerHTML = `
			                        <h4>${request.requestType}</h4>
			                        <p>${request.description}</p>
			                        <p>Status: ${request.status}</p>
			                        <p>Requested on: ${request.formattedRequestedDate}</p> <!-- Use the formatted date here -->
			                    `;
			                    requestsDiv.appendChild(requestDiv);
			                });
			            }
			        })
			        .catch(error => {
			            console.error('Error fetching requests:', error);
			        });
			});
		</script>
 
 
</body>
</html>
 
 
 