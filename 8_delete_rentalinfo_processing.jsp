<%--
  Created by IntelliJ IDEA.
  User: CCINFOM_GROUP26
  Date: 04/04/2023
  Time: 5:59 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, com.example.assets_hoa.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Rental Info Deletion</title>
    <style>
            body {
                font-family: Arial;
                background-color: #f2f2f2;
            }

            input[type=text], select {
                width: 100%;
                padding: 12px 20px;
                margin: 8px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            input[type=submit] {
                width: 100%;
                background-color: #4CAF50;
                color: white;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type=submit]:hover {
                background-color: #45a049;
            }

            div {
                border-radius: 5px;
                background-color: #ffffff;
                padding: 20px;
            }
    </style>
</head>
<body>

<div>
    <form action="index.jsp">
        <jsp:useBean id="transaction" class="com.example.assets_hoa.asset_transaction" scope="session"/>
        <%
            transaction.clear();
            int v_asset_id = Integer.parseInt(request.getParameter("asset_id"));
            String v_transaction_date = request.getParameter("transaction_date");
            transaction.setTransaction_date(v_transaction_date);
            transaction.setAsset_id(v_asset_id);

            if (transaction.markDeleteTransaction() == 1) {
        %>
        <h1>Rental Information Deleted Successfully!</h1>
        <% } else { %>
        <h1>Rental Information Delete Failed!</h1>
        <h2>Please try again</h2>
        <%}%>

        <input type="submit" value="Return to Main Menu">
    </form>
</div>

</body>
</html>
