<!-- <!DOCTYPE html>
<html>
<head>
    <title>Tenant Payment Page</title>
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
        input, select {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            width: 100%;
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
        .receipt-upload {
            display: none;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            fetch('/api/payment/details?tenantId=1')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('bank_details').innerText = data.bankDetails;
                    document.getElementById('upi_details').innerText = data.upiDetails;
                    document.getElementById('amount').value = data.amount; // Set the amount
                });
 
            document.getElementById('payment_method').addEventListener('change', function() {
                const receiptUpload = document.querySelector('.receipt-upload');
                receiptUpload.style.display = (this.value === 'BankTransfer' || this.value === 'UPI') ? 'block' : 'none';
            });
 
            document.getElementById('payment_details').addEventListener('change', function() {
                const bankDetails = document.getElementById('bank_details');
                const upiDetails = document.getElementById('upi_details');
                bankDetails.style.display = (this.value === 'BankDetails') ? 'block' : 'none';
                upiDetails.style.display = (this.value === 'UPIDetails') ? 'block' : 'none';
            });
        });
 
        function handlePaymentSubmit(event) {
            event.preventDefault();
            const form = event.target;
            const formData = new FormData(form);
 
            fetch(form.action, {
                method: form.method,
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                // Redirect to success page
                window.location.href = 'submitPayment'; // Adjust the path as necessary
            })
            .catch(error => {
                alert('An error occurred: ' + error.message);
            });
 
            return false;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Tenant Payment Page</h2>
        <label for="payment_details">Payment Details:</label>
        <select id="payment_details" name="payment_details" required>
            <option value="BankDetails">Bank Details</option>
            <option value="UPIDetails">UPI Details</option>
        </select>
        <label for="bank_details" style="display:none;">Bank Details:</label>
        <p id="bank_details" style="display:none;"></p>
        <label for="upi_details" style="display:none;">UPI Details:</label>
        <p id="upi_details" style="display:none;"></p>
        <form action="/api/payment/submit" method="post" enctype="multipart/form-data" onsubmit="return handlePaymentSubmit(event)">
            <input type="hidden" name="tenantId" value="1" />
            <label for="amount">Amount</label>
            <input type="number" id="amount" name="amount" readonly />
            <label for="payment_method">Payment Method</label>
            <select id="payment_method" name="payment_method" required>
                <option value="BankTransfer">Bank Transfer</option>
                <option value="UPI">UPI</option>
                <option value="Cash">Cash</option>
            </select>
            <div class="receipt-upload">
                <label for="receipt">Upload Receipt</label>
                <input type="file" id="receipt" name="receipt" accept="image/*">
            </div>
            <button type="submitPayment">Submit</button>
        </form>
    </div>
</body>
</html> -->

<!DOCTYPE html>
<html>
<head>
    <title>Tenant Payment Page</title>
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
            margin-top: 100px;
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
        input, select {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            width: 100%;
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
        .receipt-upload {
            display: none;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            fetch('/api/payment/details?tenantId=1')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('bank_details').innerText = data.bankDetails;
                    document.getElementById('upi_details').innerText = data.upiDetails;
                    document.getElementById('amount').value = data.amount; // Set the amount
                });
 
            document.getElementById('payment_method').addEventListener('change', function() {
                const receiptUpload = document.querySelector('.receipt-upload');
                receiptUpload.style.display = (this.value === 'BankTransfer' || this.value === 'UPI') ? 'block' : 'none';
            });
 
            document.getElementById('payment_details').addEventListener('change', function() {
                const bankDetails = document.getElementById('bank_details');
                const upiDetails = document.getElementById('upi_details');
                bankDetails.style.display = (this.value === 'BankDetails') ? 'block' : 'none';
                upiDetails.style.display = (this.value === 'UPIDetails') ? 'block' : 'none';
            });
        });
 
        function handlePaymentSubmit(event) {
            event.preventDefault();
            const form = event.target;
            const formData = new FormData(form);
 
            fetch(form.action, {
                method: form.method,
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                // Redirect to success page
                window.location.href = 'submitPayment'; // Adjust the path as necessary
            })
            .catch(error => {
                alert('An error occurred: ' + error.message);
            });
 
            return false;
        }
    </script>
</head>
<body>
	<%@include file="header.jsp" %>
	
    <div class="container">
        <h2>Tenant Payment Page</h2>
        <label for="payment_details">Payment Details:</label>
        <select id="payment_details" name="payment_details" required>
            <option value="BankDetails">Bank Details</option>
            <option value="UPIDetails">UPI Details</option>
        </select>
        <label for="bank_details" style="display:none;">Bank Details:</label>
        <p id="bank_details" style="display:none;"></p>
        <label for="upi_details" style="display:none;">UPI Details:</label>
        <p id="upi_details" style="display:none;"></p>
        <form action="/api/payment/submit" method="post" enctype="multipart/form-data" onsubmit="return handlePaymentSubmit(event)">
            <input type="hidden" name="tenantId" value="1" />
            <label for="amount">Amount</label>
            <input type="number" id="amount" name="amount" readonly />
            <label for="payment_method">Payment Method</label>
            <select id="payment_method" name="payment_method" required>
                <option value="BankTransfer">Bank Transfer</option>
                <option value="UPI">UPI</option>
                <option value="Cash">Cash</option>
            </select>
            <div class="receipt-upload">
                <label for="receipt">Upload Receipt</label>
                <input type="file" id="receipt" name="receipt" accept="image/*">
            </div>
            <button type="submitPayment">Submit</button>
        </form>
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
 