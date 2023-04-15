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
    <title>Return Asset Rental Info</title>
    <style>
            body {
                font-family: "Times New Roman", serif;
                background-color: #f2f2f2;
            }

            input[type=text], input[type=number], input[type=date], select {
                width: 100%;
                padding: 10px;
                margin: 8px 0;
                display: block;
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
                border: 1px solid #ccc;
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
                border-radius: 4px;
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
    <h3>Return Asset Rental Information Form</h3>
    <form action="6_return_rental_processing.jsp">
        <jsp:useBean id="rental" class="com.example.assets_hoa.asset_rentals" scope="session"/>
        <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
        <jsp:useBean id="accept_ofc" class="com.example.assets_hoa.reference_officer" scope="session"/>
        <%
            rental.clear();
            asset.clear();
            accept_ofc.clear();
            //split value from request parameter delimited by "\\|"
            String[] values = request.getParameter("asset_id").split("\\|");
            int v_asset_id = Integer.parseInt(values[0]);
            String v_rental_date = values[1];

            rental = rental.getRentalInfo(v_asset_id, v_rental_date);
            asset = asset.getAssetInfo(v_asset_id);
            List<reference_officer> accepting_ofc_list = accept_ofc.getAcceptOfc_list();
            // Get the list of enclosed assets, if any
            List<assets> enclosed_assets = asset.getEnclosed_RentedAssets(v_rental_date);
        %>
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
            <option value="<%=rental.getStatusEnum("Returned")%>">Returned</option>
        </select><br>
        Reservation Date:
        <label for="reservation_date"></label>
        <input type="date" id="reservation_date"
               name="reservation_date" value="<%=rental.getReservation_date()%>" readonly>
        <br>
        Rental Date:
        <label for="rental_date"></label>
        <input type="date" id="rental_date"
               name="rental_date" value="<%=rental.getRental_date()%>" readonly>
        <br>
        Return Date:
        <label for="return_date"></label>
        <input type="date" id="return_date"
               name="return_date" required>
        <br>
        Rental Amount: <label for="rental_amount"></label>
        <input type="number" id="rental_amount" value="<%=rental.getRental_amount()%>" name="rental_amount" required>
        <br>
        Discount: <label for="discount_amount"></label>
        <input type="number" id="discount_amount" value="<%=rental.getDiscount()%>" name="discount_amount" required>
        <br>
        Inspection Details: <label for="inspection_details"></label>
        <input type="text" id="inspection_details" name="inspection_details" required>
        <br>
        Assessed Value: <label for="assessed_value"></label>
        <input type="number" id="assessed_value" name="assessed_value" required>
        <br>
        Accepting Officer:
        <label for="accepting_ofc"></label>
        <select id="accepting_ofc" name="accepting_ofc">
            <%
                for (reference_officer rofc : accepting_ofc_list) { %>
            <option value="<%=rofc.getHoa_id()%>|<%=rofc.getPosition()%>|<%=rofc.getElection_date()%>">
                (ID:<%=rofc.getHoa_id()%>) <%=rofc.getPosition()%>
            </option>
            <% } %>
        </select><br>
        <input type="submit" value="Update">
    </form>
</div>

</body>
</html>
