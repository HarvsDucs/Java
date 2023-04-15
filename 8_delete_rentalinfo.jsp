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
    <title>Delete Asset Rental Info</title>
    <style>
            body {
                font-family: Arial, serif;
                background-color: #f2f2f2;
            }

            input[type=text], input[type=number], input[type=date], select {
                width: 100%;
                padding: 12px 20px;
                margin: 8px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            input[type=number]::-webkit-outer-spin-button,
            input[type=number]::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            input[type=checkbox] {
                margin: 8px 0;
                border: 1px solid #ccc;
                height: 20px;
                width: 20px;
                vertical-align: middle;
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
    <h3>Delete Asset Rental Information Form</h3>
    <jsp:useBean id="rental" class="com.example.assets_hoa.asset_rentals" scope="session"/>
    <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
    <jsp:useBean id="transaction" class="com.example.assets_hoa.asset_transaction" scope="session"/>
    <jsp:useBean id="approve_ofc" class="com.example.assets_hoa.reference_officer" scope="session"/>
    <%
        rental.clear();
        asset.clear();
        transaction.clear();
        approve_ofc.clear();
        // Get the list of assets rental info to update
        List<asset_transaction> transToDelete = transaction.getRentalTransacList();
        List<reference_officer> approveOfcList = approve_ofc.getApprovingOfc_list();
        // Check if the list is empty
        if (transToDelete.isEmpty()) {
            // If the list is empty, show a message and disable the submit button
    %>
    <p>No Available Transaction Form to Delete!.</p>
    <form action ="index.jsp">
        <input type="submit" value="Go Back To Main Menu">
    </form>
    <%
    } else if (approveOfcList.isEmpty()) {
        // Check if no approving officer is available
    %>
    <p>No Available Approving Officer Today!</p>
    <form action ="index.jsp">
        <input type="submit" value="Go Back To Main Menu">
    </form>
    <%
    }  else {
    %>
    <form action="8_delete_chosen_rentalinfo.jsp">
        Rental Info to Update
        <label for="asset_id"></label>
        <select id="asset_id" name="asset_id">
            <%
                for (asset_transaction at : transToDelete) {
                    assets a = asset.getAssetInfo(at.getAsset_id());
            %>
            <option value="<%=a.getAsset_id()%>|<%=at.getTransaction_date()%>">
                (ID:<%=a.getAsset_id()%>) <%=a.getAsset_name()%>
                 (Transaction Date: <%=at.getTransaction_date()%>)
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
