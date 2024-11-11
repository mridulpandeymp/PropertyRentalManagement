<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <div class="container">
        <h1>View Reports</h1>
        <form action="${pageContext.request.contextPath}/generate-report" method="post">
            <select name="reportType" required>
                <option value="" disabled selected>Select Report Type</option>
                <option value="occupancy">Occupancy Report</option>
                <option value="revenue">Revenue Report</option>
                <!-- Add more report types as needed -->
            </select>
            <button type="submit">Generate Report</button>
        </form>
        <a href="/user/openLandlordDashboard" class="button">Back to Dashboard</a>
    </div>
</body>
</html>
