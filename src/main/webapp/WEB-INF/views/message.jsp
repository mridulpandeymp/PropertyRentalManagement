<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<p style="font-weight:bold; text-align:center; margin-top: 20px;">
<%

    String message = (String) request.getAttribute("message");

    if (message != null) {

        out.println("<span style='color:red; font-size: 18px;'>" + message + "</span>");

    }

    %>
</p>

 