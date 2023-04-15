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
    <title>Update Asset Rental Info</title>
    <style>
            body {
                font-family: Arial, serif;
                background-color: #f2f2f2;
            }

            input[type=text], input[type=number], input[type=date], select {
                width: 100%;
                padding: 12px;
                margin: 8px 0;
                display: block;
                border: none;
                border-bottom: 1px solid #ccc;
                background-color: #f8f8f8;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 14px;
            }

            input[type=number]::-webkit-outer-spin-button,
            input[type=number]::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            input[type=checkbox] {
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                height: 20px;
                width: 20px;
                vertical-align: middle;
            }

            input[type=submit] {
                width: 100%;
                background-color: #4CAF50;
                color: white;
                padding: 12px;
                margin: 8px 0;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s ease;
                font-size: 16px;
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
    <h3>Update Asset Rental Information Form</h3>
    <jsp:useBean id="rental" class="com.example.assets_hoa.asset_rentals" scope="session"/>
    <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
    <%
        rental.clear();
        asset.clear();
        // Get the list of assets rental info to update
        List<asset_rentals> rentalsForUpdate = rental.getRentalsToUpdate();
        // Check if the list is empty
        if (rentalsForUpdate.isEmpty()) {
            // If the list is empty, show a message and disable the submit button
    %>
    <p>No Such Rental Records to Update.</p>
    <form action ="index.jsp">
        <input type="submit" value="Go Back To Main Menu">
    </form>
    <%
    } else {
        // If the list is not empty, show the dropbox and enable the submit button
    %>
    <form action="7_update_chosen_rentalinfo.jsp">
        Rental Info to Update
        <label for="asset_id"></label>
        <select id="asset_id" name="asset_id">
            <%
                for (asset_rentals ar : rentalsForUpdate) {
                    assets a = asset.getAssetInfo(ar.getAsset_id());
            %>
            <option value="<%=a.getAsset_id()%>|<%=ar.getRental_date()%>">
                (ID:<%=a.getAsset_id()%> <%=a.getAsset_name()%> | <%=ar.getStatusString()%>)
                (Rental Date: <%=ar.getRental_date()%>)
            </option>
            <% } %>
        </select><br>
        <input type="submit" value="Check Asset Rental Information">
    </form>
    <%
        }
    %>
</div>

</body>
</html>
