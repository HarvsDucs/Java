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
                font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
                background-color: #e6e6e6;
            }

            input[type=text], input[type=number], input[type=date], select {
                width: 100%;
                padding: 12px 16px;
                margin: 8px 0;
                display: inline-block;
                border: none;
                border-bottom: 1px solid #ccc;
                background-color: #f8f8f8;
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
                background-color: #f8f8f8;
                border-radius: 2px;
            }

            input[type=submit] {
                width: 100%;
                background-color: #007bff;
                color: white;
                padding: 14px 20px;
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
                background-color: #f8f8f8;
                padding: 20px;
            }
    </style>
</head>
<body>

<div>
    <h3>Record Asset Rental Form</h3>
    <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
    <jsp:useBean id="resident" class="com.example.assets_hoa.reference_resident" scope="session"/>
    <jsp:useBean id="rental" class="com.example.assets_hoa.asset_rentals" scope="session"/>
    <jsp:useBean id="transaction" class="com.example.assets_hoa.asset_transaction" scope="session"/>
    <jsp:useBean id="trans_officer" class="com.example.assets_hoa.reference_officer" scope="session"/>
    <%
        asset.clear();
        rental.clear();
        transaction.clear();
        asset = asset.getAssetInfo(Integer.parseInt(request.getParameter("asset_id")));

        // Get the list of enclosed assets, if any
        List<assets> enclosed_assets = asset.getEnclosed_assets();
        List<reference_officer> transOfcList = trans_officer.getTransOfc_list();
        LocalDate today = LocalDate.now();
    %>
    <form action="5_record_rental_processing.jsp">
        Asset Name:
        <label>
            <input type="text" name="asset_name"
                   value="<%=asset.getAsset_name()%>" readonly>
        </label><br>

        Asset ID:
        <label>
            <input type="text" id="asset_id" name="asset_id"
                   value="<%=asset.getAsset_id()%>" readonly>
        </label><br>
        <%if (!enclosed_assets.isEmpty()) {%>
        Enclosed Assets:
        <label for="enclosed_assets"></label>
        <select id="enclosed_assets" name="enclosed_assets">
            <%
                for (assets a : enclosed_assets) { %>
            <option value="<%=a.getAsset_id()%>">(ID:<%=a.getAsset_id()%>) <%=a.getAsset_name()%></option>
            <% } %>
        </select><br>
        <% } %>

        Rental Status:
        <label for="rental_status"></label>
        <select id="rental_status" name="rental_status">
            <option value="R">Reserved</option>
        </select><br>

        Renter ID:
        <label for="resident_id"></label>
        <select id="resident_id" name="resident_id">
            <%
                for (reference_resident r : resident.getRes_list_not_renters()) { %>
            <option value="<%=r.getResident_id()%>">ID:<%=r.getResident_id()%></option>
            <% } %>
        </select><br>
        Reservation Date: <label for="reservation_date"></label>
        <input type="date" id="reservation_date" name="reservation_date" value="<%=today%>" readonly>
        <br>
        Rental Date: <label for="rental_date"></label>
        <input type="date" id="rental_date" name="rental_date" required>
        <br>
        Transaction Officer ID:
        <label for="trans_ofc"></label>
        <select id="trans_ofc" name="trans_ofc">
            <%
                for (reference_officer rofc : transOfcList) { %>
            <option value="<%=rofc.getHoa_id()%>|<%=rofc.getPosition()%>|<%=rofc.getElection_date()%>">
                (ID:<%=rofc.getHoa_id()%>) <%=rofc.getPosition()%>
            </option>
            <% } %>
        </select><br>
        <input type="submit" value="Register">
    </form>
</div>

</body>
</html>

