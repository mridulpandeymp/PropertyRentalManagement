<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Enter Email</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f1fefb;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-image: url('https://example.com/background-image.jpg'); /* Replace with your image */
            background-size: cover;
            background-position: center;
            color: #295F98;
        }
 
        .login-container {
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            width: 320px;
            text-align: center;
            background-color: #FFFFFF;
            opacity: 0.9;
        }
 
        h2 {
            margin-bottom: 20px;
            color: #FF6F61; /* Changed color for better contrast */
        }
 
        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }
 
        .input-group label {
            display: block;
            margin-bottom: 5px;
            color: #295F98;
            font-weight: bold;
        }
 
        .input-group input {
            width: 100%;
            padding: 10px;
            border: 2px solid #FF6F61;
            border-radius: 4px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
 
        .input-group input:focus {
            border-color: #295F98;
            outline: none;
        }
 
        button {
            width: 100%;
            padding: 10px;
            background-color: #295F98;
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 20px;
        }
 
        button:hover {
            background-color: #1a3a6e;
        }
 
        .error {
            color: red;
            margin-top: 10px;
            text-align: center;
        }
 
        .image-container {
            margin-top: 20px;
        }
 
        img {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Forgot Password?</h2>
        <form action="${pageContext.request.contextPath}/user/verify_email" method="post">
            <div class="input-group">
                <label for="email">Enter your email</label>
                <input type="email" id="email" name="email" required placeholder="example@gmail.com">
            </div>
            <button type="submit">Verify Email</button>
 
            <%-- Display error if email is not found --%>
            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>
        </form>
 
        <div class="image-container">
            <img src="https://static.vecteezy.com/system/resources/previews/002/174/758/original/forgot-password-landing-page-template-vector.jpg" alt="Forgot Password Illustration"> <!-- Replace with your image -->
        </div>
    </div>
    
</body>
</html>
 
 