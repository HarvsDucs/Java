<%--
  Created by IntelliJ IDEA.
  User: CCINFOM_GROUP26
  Date: 04/04/2023
  Time: 5:59 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, com.example.assets_hoa.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<!DOCTYPE html>
<html>
<head>
    <title>Return Asset Rental Processing</title>
    <style>
            body {
                font-family: Arial, serif;
                background-color: #f2f2f2;
            }

            input[type=text], select {
                width: 100%;
                padding: 10px;
                margin: 8px 0;
                display: block;
                border: none;
                border-bottom: 1px solid #ccc;
                background-color: #f8f8f8;
                border-radius: 4px;
                box-sizing: border-box;
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
    <h3>Return Asset Rental Form</h3>
    <form action="index.jsp">
        <jsp:useBean id="asset" class="com.example.assets_hoa.assets" scope="session"/>
        <jsp:useBean id="resident" class="com.example.assets_hoa.reference_resident" scope="session"/>
        <jsp:useBean id="rental" class="com.example.assets_hoa.asset_rentals" scope="session"/>
        <jsp:useBean id="transaction" class="com.example.assets_hoa.asset_transaction" scope="session"/>
        <%
            asset.clear();
            resident.clear();
            rental.clear();
            transaction.clear();

            int v_asset_id = Integer.parseInt(request.getParameter("asset_id"));
            String v_rental_date = request.getParameter("rental_date");
            String v_return_date = request.getParameter("return_date");
            char v_rental_status = request.getParameter("rental_status").charAt(0);
            double v_rental_amount = Double.parseDouble(request.getParameter("rental_amount"));
            double v_discount_amount = Double.parseDouble(request.getParameter("discount_amount"));
            String v_inspection_details = request.getParameter("inspection_details");
            double v_assessed_value = Double.parseDouble(request.getParameter("assessed_value"));
            String [] ofcInfo = request.getParameter("accepting_ofc").split("\\|");
            int v_accept_id = Integer.parseInt(ofcInfo[0]);
            String v_accept_position = ofcInfo[1];
            String v_accept_election = ofcInfo[2];

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            boolean isValidDate = true;
            Date rental_date = null;
            Date return_date = null;

            if (v_return_date != null && !v_return_date.equals("")) {
                try {
                    return_date = sdf.parse(v_return_date);
                    rental_date = sdf.parse(v_rental_date);
                } catch (ParseException e) {
                    isValidDate = false;
                }
                assert rental_date != null;
                if (rental_date.after(return_date)) {
                    isValidDate = false;
                }
            }

            rental = rental.getRentalInfo(v_asset_id, v_rental_date);
            rental.setStatus(v_rental_status);
            rental.setRental_date(v_rental_date);
            rental.setDiscount(v_discount_amount);
            rental.setRental_amount(v_rental_amount);
            rental.setInspection_details(v_inspection_details);
            rental.setAssessed_value(v_assessed_value);
            rental.setAccept_hoid(v_accept_id);
            rental.setAccept_position(v_accept_position);
            rental.setAccept_electiondate(v_accept_election);
            rental.setReturn_date(v_return_date);

            resident.setResident_id(rental.getResident_id());

            if (isValidDate && rental.update_rental() == 1 && resident.setResident_not_renting() == 1) {
        %>
        <h1>Asset Rental Returned Successfully!</h1>
        <% } else { %>
        <h1>Asset Rental Return Failed!</h1>
        <h2>Please try again</h2>
        <%}%>

        <input type="submit" value="Return to Main Menu">
    </form>
</div>

</body>
</html>