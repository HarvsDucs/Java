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
                font-family: Arial;
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
    <jsp:useBean id="rental" class="com.example.assets_hoa.asset_rentals" scope="session"/>
    <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
    <jsp:useBean id="transaction" class="com.example.assets_hoa.asset_transaction" scope="session"/>
    <jsp:useBean id="approve_ofc" class="com.example.assets_hoa.reference_officer" scope="session"/>
    <%
        rental.clear();
        asset.clear();
        transaction.clear();
        //split value from request parameter delimited by "\\|"
        String[] values = request.getParameter("asset_id").split("\\|");
        int v_asset_id = Integer.parseInt(values[0]);
        String v_rental_date = values[1];

        rental = rental.getRentalInfo(v_asset_id, v_rental_date);
        asset = asset.getAssetInfo(v_asset_id);
        transaction = transaction.getTransactInfo(v_asset_id, v_rental_date);
        List<reference_officer> approving_officers = approve_ofc.getApprovingOfc_list();
    %>
    <h3>Delete Asset Rental Information Form</h3>
    <form action="8_delete_rentalinfo_processing.jsp">
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

        Reservation Date:
        <label for="reservation_date"></label>
        <input type="date" id="reservation_date"
               name="reservation_date" value="<%=rental.getReservation_date()%>" readonly>
        <br>

        Rental/Transaction Date:
        <label for="transaction_date"></label>
        <input type="date" id="transaction_date"
               name="transaction_date" value="<%=transaction.getTransaction_date()%>" readonly>
        <br>

        Return Date:
        <label for="return_date"></label>
        <input type="date" id="return_date"
               name="return_date" value="<%=rental.getReturn_date()%>" readonly>
        <br>

        Rental Amount: <label for="rental_amount"></label>
        <input type="number" id="rental_amount" name="rental_amount" value="<%=rental.getRental_amount()%>" readonly>
        <br>

        Discount: <label for="discount_amount"></label>
        <input type="number" id="discount_amount" name="discount_amount" value="<%=rental.getDiscount()%>" readonly>
        <br>

        Rental Status:
        <label for="rental_status"></label>
        <select id="rental_status" name="rental_status">
            <option value="<%=rental.getStatus()%>"><%=rental.getStatusString()%></option>
        </select><br>
        Inspection Details: <label for="inspection_details"></label>
        <input type="text" id="inspection_details" name="inspection_details"
               value="<%=rental.getInspection_details()%>" readonly>
        <br>
        Assessed Value: <label for="assessed_value"></label>
        <input type="number" id="assessed_value" name="assessed_value" value="<%=rental.getAssessed_value()%>" readonly>
        <br>
        Accepting Officer: <label for="accepting_officer"></label>
        <input type="text" id="accepting_officer" name="accepting_officer"
               value=" (ID: <%= rental.getAccept_hoid()%>) <%=rental.getAccept_position()%>" readonly>

        Transaction Officer: <label for="transaction_officer"></label>
        <input type="text" id="transaction_officer" name="transaction_officer"
               value=" (ID: <%= transaction.getTrans_hoid()%>) <%=transaction.getTrans_position()%>" readonly>
        <br>
        OR Number: <label for="or_number"></label>
        <input type="text" id="or_number" name="or_number" value="<%=transaction.getOrnum()%>" readonly>
        <br>
        Transaction Type: <label for="transaction_type"></label>
        <select id="transaction_type" name="transaction_type">
            <option
                    value="<%=transaction.getTransaction_type()%>"><%=transaction.getTransactionType_String()%>
            </option>
        </select>
        <br>
        Approving Officer: <label for="approving_officer"></label>
        <select id="approving_officer" name="approving_officer">
            <%
                for (reference_officer rofc : approving_officers) { %>
            <option value="<%=rofc.getHoa_id()%>|<%=rofc.getPosition()%>|<%=rofc.getElection_date()%>">
                (ID:<%=rofc.getHoa_id()%>) <%=rofc.getPosition()%>
            </option>
            <% } %>
        </select><br>
        <input type="submit" value="Delete Transaction And Rental Information">
    </form>
</div>

</body>
</html>
