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
    <title>Return an Asset From Rent</title>
    <style>
            body {
                font-family: "Helvetica", sans-serif;
                background-color: #f2f2f2;
            }

            input[type=text], input[type=number], input[type=date], select {
                width: 100%;
                padding: 10px;
                margin: 8px 0;
                display: block;
                border: none;
                border-bottom: 1px solid #ddd;
                background-color: #f8f8f8;
                border-radius: 3px;
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
                background-color: #f8f8f8;
                height: 20px;
                width: 20px;
                vertical-align: middle;
            }

            input[type=submit] {
                width: 100%;
                background-color: #2ecc71;
                color: white;
                padding: 12px;
                margin: 8px 0;
                border: none;
                border-radius: 3px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            input[type=submit]:hover {
                background-color: #27ae60;
            }

            div {
                border-radius: 5px;
                background-color: #ffffff;
                padding: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
    </style>
</head>
<body>

<div>
    <h3>Return Rented Asset Form</h3>
    <jsp:useBean id="rental" class="com.example.assets_hoa.asset_rentals" scope="session"/>
    <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
    <jsp:useBean id="accept_ofc" class="com.example.assets_hoa.reference_officer" scope="session"/>
    <%
        rental.clear();
        asset.clear();
        accept_ofc.clear();
        // Get the list of assets rental info to update
        List<asset_rentals> rentalsForReturn = rental.assetsOnRentList();
        List<reference_officer> acceptOfcList = accept_ofc.getAcceptOfc_list();
        // Check if the list is empty
        if (rentalsForReturn.isEmpty()) {
            // If the list is empty, show a message and disable the submit button
    %>
    <p>No Available Assets to Return!.</p>
    <form action ="index.jsp">
        <input type="submit" value="Go Back To Main Menu">
    </form>
    <%
    } else if (acceptOfcList.isEmpty()) {
        // Check if no accepting officer is available
    %>
    <p>No Available Accepting Officer Today!</p>
    <form action ="index.jsp">
        <input type="submit" value="Go Back To Main Menu">
    </form>
    <%
    }  else {
        // If the list is not empty, show the dropbox and enable the submit button
    %>
    <form action="6_return_chosen_rental.jsp">
        Asset To Return:
        <label for="asset_id"></label>
        <select id="asset_id" name="asset_id">
            <%
                for (asset_rentals ar : rentalsForReturn) {
                    assets a = asset.getAssetInfo(ar.getAsset_id());
            %>
            <option value="<%=a.getAsset_id()%>|<%=ar.getRental_date()%>">
                (ID:<%=a.getAsset_id()%>) <%=a.getAsset_name()%> | <%=a.getType_assetString()%>
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
