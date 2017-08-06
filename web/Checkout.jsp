<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: sowmya
  Date: 1/19/17
  Time: 2:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CheckOut</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" href = "bootstrap/css/bootstrap.min.css">
    <link rel = "stylesheet" href = "font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel = "stylesheet" href = "Sheet1.css">
    <script src= "http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/jquery.validation/1.15.0/jquery.validate.min.js"></script>
    <script src="https://cdn.jsdelivr.net/jquery.validation/1.15.0/additional-methods.min.js"></script>
</head>
<body>

<div class="navbar-wrapper">
    <div class="container">
        <div class="navbar navbar-static-top navbar-inverse">
            <div class="navbar-header">
                <img id="headingimg" class="navbar-brand" src="heading.jpg">
            </div>
            <div id="navbar" class="navbar-right">
                <ul class="nav navbar-nav">
                    <li>
                        <a href='Home.jsp' class="btn btn-primary">Home</a>
                    </li>
                    <li>
                        <p class="btn btn-primary">Welcome <%=session.getAttribute("name")%></p>
                    </li>
                    <li>
                        <a href='logout.jsp' class="btn btn-primary">Log out</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid main">

    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Your Cart</h4>
                </div>
                <div class="panel-body">
                    <%
                        String user = (String) session.getAttribute("user");
                        Connection myConn = null;
                        String url = "jdbc:mysql://localhost:3306/projectforkknife";
                        String username = "root";
                        String password = "root";
                        PreparedStatement st=null;
                        ResultSet rs=null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            myConn = DriverManager.getConnection(url, username, password);
                            double total = 0;
                            st = myConn.prepareStatement("select product_name,cost,quantity from cart where user = ?");
                            st.setString(1, user);
                            rs = st.executeQuery();
                            while (rs.next()) {
                                total += (rs.getInt("cost") * rs.getInt("quantity"));
                                out.println("<div class=\"row\"><div class=\"col-md-4\">" + rs.getString("product_name")+"</div>");
                                out.println("<div class=\"col-md-4\"> cost: " + rs.getInt("cost") +"</div>");
                                out.println("<div class=\"col-md-4\"> quantity: " + rs.getString("quantity") + "</div></div>");
                            }
                            out.println("<div class=\"panel-footer\"><div class=\"col-md-8\">Total: </div>");
                            out.println("<div class=\"col-md-4\">"+total+"</div></div>");
                        }catch(Exception e){
                            e.printStackTrace();
                        }
                    %>
                    <button type="button" onclick='checkout()' class="btn btn-default">Confirm Checkout</button>
                </div>
            </div>
        </div>
    </div>
</div>

<footer>
    <div class="row center-block">
        <div class="col-md-12">
            <ul class="center-block">
                <li>
                    <span> • </span>
                    <a href="#">About</a>
                </li>
                <li>
                    <span> • </span>
                    <a href="#">Terms and Conditions</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4" id="social" >
            <i class="fa fa-facebook-square fa-2x" aria-hidden="true"></i>
            <i class="fa fa-pinterest-square fa-2x" aria-hidden="true"></i>
            <i class="fa fa-twitter-square fa-2x" aria-hidden="true"></i>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 col-md-offset-4" id="footer">
            <p>2017 Fork & Knife</p>
        </div>
    </div>
</footer>

</body>
</html>
<script>
    function checkout(){
        console.log("true");
        $.post("ConfirmOrder",function(data){
            if(data==1){
                alert("Order placed Successfully");
                window.location = "Home.jsp";
            }
        });
    }
</script>
