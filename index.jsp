<!DOCTYPE html>
<html>
<head>
    <title>Assets - MAIN MENU</title>
    <style>
            body {
                font-family: Arial, Helvetica, sans-serif;
            }

            .menu {
                list-style-type: none;
                margin: 0;
                padding: 0;
                width: 200px;
            }

            .menu li a {
                display: block;
                color: #000;
                padding: 12px;
                text-decoration: none;
                border-bottom: 5px solid #eee;
                margin-bottom: 5px;
                transition: background-color 0.3s ease; /* Added transition for smooth hover effect */
            }

            .menu li a:hover {
                background-color: #4CAF50;
                color: white;
            }
    </style>
</head>
<body>
<h1><%= "HOA Assets - MAIN MENU" %></h1>
<h1><%= "Welcome, Officer!" %></h1>
<br/>
<ul class="menu">
    <li><a href="1_register_asset.jsp">Register an Asset</a></li>
    <li><a href="2_update_asset.jsp">Update Asset Information</a></li>
    <li><a href="3_delete_wrongasset.jsp">Delete Wrongly Encoded Asset</a></li>
    <li><a href="4_dispose_asset.jsp">Dispose an Asset</a></li>
    <li><a href="5_record_rental.jsp">Record Asset Rental</a></li>
    <li><a href="7_update_rentalinfo.jsp">Update Asset Rental Information</a></li>
    <li><a href="6_return_rental.jsp">Return Asset Rental</a></li>
    <li><a href="8_delete_rentalinfo.jsp">Delete Asset Rental Information</a></li>
</ul>

</body>
</html>