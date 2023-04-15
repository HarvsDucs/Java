<%--
  Created by IntelliJ IDEA.
  User: CCINFOM_GROUP26
  Date: 04/04/2023
  Time: 5:59 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, com.example.assets_hoa.*, java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
    <title>Record Asset Rental</title>
    <style>
            body {
                font-family: "Roboto", Arial, sans-serif;
                background-color: #e9e9e9;
            }

            input[type=text], input[type=number], input[type=date], select {
                width: 100%;
                padding: 10px;
                margin: 8px 0;
                display: block;
                border: none;
                border-bottom: 1px solid #ccc;
                background-color: #f4f4f4;
                border-radius: 2px;
                box-sizing: border-box;
            }

            input[type=number]::-webkit-outer-spin-button,
            input[type=number]::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            input[type=checkbox] {
                margin: 8px 0;
                display: inline-block;
                border: none;
                height: 20px;
                width: 20px;
                vertical-align: middle;
                background-color: #f4f4f4;
                border-radius: 2px;
            }

            input[type=submit] {
                width: 100%;
                background-color: #007bff;
                color: white;
                padding: 12px;
                margin: 8px 0;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            input[type=submit]:hover {
                background-color: #0056b3;
            }

            div {
                border-radius: 4px;
                background-color: #ffffff;
                padding: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
    </style>
</head>
<body>

<div>
    <h3>Choose Available Asset To Rent</h3>
    <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
    <jsp:useBean id="trans_officer" class="com.example.assets_hoa.reference_officer" scope="session"/>
    <%
        asset.clear();
        // Get the list of assets rental info to update
        List<assets> assetsForRent = asset.getForRent();
        List<reference_officer> transOfcList = trans_officer.getTransOfc_list();
        LocalDate today = LocalDate.now();
        // Check if assets list is empty
        if (assetsForRent.isEmpty()) {
            // If the list is empty, show a message and disable the submit button
    %>
        <p>No Available Items To Rent!.</p>
        <form action ="index.jsp">
        <input type="submit" value="Go Back To Main Menu">
        </form>
    <%
    } else if (transOfcList.isEmpty()) {
            // Check if no transaction officer is available
    %>
        <p>No Available Transaction Officer Today!</p>
        <form action ="index.jsp">
            <input type="submit" value="Go Back To Main Menu">
        </form>
    <%
        }  else {
        // If the list is not empty, show the dropbox and enable the submit button
    %>
    <form action="5_record_chosen_rental.jsp">
        Asset To Rent:
        <label for="asset_id"></label>
        <select id="asset_id" name="asset_id">
            <%
                for (assets a : assetsForRent) { %>
            <option value="<%=a.getAsset_id()%>">
                (ID:<%=a.getAsset_id()%>) <%=a.getAsset_name()%> | <%=a.getType_assetString()%>
                <%
                    if (a.getEnclosing_asset() != 0) {
                %>
                | Enclosed in ID: <%=a.getEnclosing_asset()%>
                <%
                    }
                %>
            </option>
            <% } %>
        </select><br>
        <input type="submit" value="Register">
    </form>
    <% } %>
</div>

</body>
</html>

