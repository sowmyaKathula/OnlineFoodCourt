<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.xml.bind.DatatypeConverter" %><%--
  Created by IntelliJ IDEA.
  User: sowmya
  Date: 1/18/17
  Time: 11:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Restaurant</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" href = "bootstrap/css/bootstrap.min.css">
    <link rel = "stylesheet" href = "font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel = "stylesheet" href = "Sheet1.css">
    <script src= "http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/jquery.validation/1.15.0/jquery.validate.min.js"></script>
    <script src="https://cdn.jsdelivr.net/jquery.validation/1.15.0/additional-methods.min.js"></script>
    <script src="LoginScript.js"></script>
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
                        <%
                            String table;
                            String user;
                            if ((session.getAttribute("user") == null) || (session.getAttribute("user") == "")) {
                                table = "tempcart";
                                user = request.getRemoteAddr();
                        %>
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#login" data-backdrop="false">Login\Register</button>
                        <%
                        } else {
                            table = "cart";
                            user = (String) session.getAttribute("user");
                        %>
                    </li>
                    <li>
                        <p class="btn btn-primary">Welcome <%=session.getAttribute("name")%></p>
                    </li>
                    <li>
                        <a href='logout.jsp' class="btn btn-primary">Log out</a>
                        <%
                            }
                        %>
                    </li>
                </ul>

                <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 align=center>Login/Register</h4>
                            </div>

                            <div class = "model-body">
                                <div class="row">
                                    <ul class="nav nav-tabs col-md-offset-1">
                                        <li class="active"><a href="#tab1" data-toggle="tab">Login</a></li>
                                        <li><a href="#tab2" data-toggle="tab">Register</a></li>
                                    </ul>
                                </div>
                                <div class="tab-content row">
                                    <div class="tab-pane active col-md-offset-2 col-md-8" id="tab1">

                                        <form class="form-horizontal" id="loginForm">
                                            <div class="input-group">
                                                <span class="input-group-addon" id="basic-addon1"><i class="glyphicon glyphicon-user"></i></span>
                                                <input type="text" class="form-control" id="phone" placeholder="PhoneNumber" name="phone" aria-describedby="basic-addon1">
                                            </div>
                                            <br>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                                <input type="password" class="form-control" id="pwd" placeholder="Password" name="password">
                                            </div>
                                            <br>
                                            <button id="loginBtn" type="submit" class="btn btn-success" style="width: 50%;margin-left: 20%;margin-top: 2%" >Login</button>
                                            <br><br>
                                        </form>

                                    </div>
                                    <div class="tab-pane col-md-offset-2 col-md-8" id="tab2">
                                        <form class="form-horizontal" id="signupform">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                <input type="text" class="form-control" name="sname" placeholder="Name" id="sname">
                                            </div>
                                            <br>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                                <input type="text" class="form-control" name="semail" placeholder="EMail" id="semail">
                                            </div>
                                            <br>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-mobile" aria-hidden="true"></i></span>
                                                <input type="text" class="form-control" name="sphone" placeholder="Phone" id="sphone">
                                            </div>
                                            <br>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-key" aria-hidden="true"></i></span>
                                                <input type="password" class="form-control" name="spassword" placeholder="Password" id="spassword">
                                            </div>
                                            <br>
                                            <button id="signupBtn" type="submit" class="btn btn-success" style="width: 50%;margin-left: 20%;margin-top: 2%" >Sign Up</button>
                                            <br><br>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <!-- End of login Modal-->
            </div>
        </div>
    </div>
    <div class="container searchbar">
        <div class="input-group input-group-lg">

            <input type="text" class="form-control location" name="location" placeholder="Search for Restaurants">
            <div class="input-group-btn">
                <input class="btn btn-default" id="search" type="submit"><i class="glyphicon glyphicon-search"></i>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid main">

    <div class="row">
        <div class="col-md-offset-1 col-md-10">

            <div class="row panel">
                <div class="col-md-2 " id="menu">
                    <ul class="nav" id="subcat">

                        <%
                            Connection myConn = null;
                            String url = "jdbc:mysql://localhost:3306/projectforkknife";
                            String username = "root";
                            String password = "root";
                            PreparedStatement st=null;
                            ResultSet rs=null;
                            String restaurant_id = request.getParameter("restaurant_id");
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                myConn = DriverManager.getConnection(url, username, password);
                                String sql="select sub_cat from subcatg where phone= '"+restaurant_id+"'";
                                st = myConn.prepareStatement(sql);
                                rs = st.executeQuery();
                                while(rs.next()){
                                    out.println("<li><a href='#"+rs.getString(1)+"'>"+rs.getString(1)+"</a></li>");
                                }
                        %>

                    </ul>
                </div>
                <div class="col-md-6" id="main" style="display:flex; flex-wrap: wrap;">
                    <%
                                String product_sql="select product_name,cost,image,product_type,product_id from product where phone= '"+restaurant_id+"'";
                                st = myConn.prepareStatement(product_sql);
                                rs = st.executeQuery();
                                int id=0;
                                while(rs.next()){
                                    byte[] imageByte = rs.getBytes("image");
                                    int product_id = rs.getInt("product_id");
                                    String imageBase64 = DatatypeConverter.printBase64Binary(imageByte);
                                    String image = "data:image/jpeg;base64,"+ imageBase64;
                                    out.println("<div class=\"col-sm-6 col-md-6\">");
                                    out.println("<div class=\"thumbnail\">");
                                    out.println("<img src='"+image+"'>");
                                    out.println("<div class=\"caption\">");
                                    out.println("<input type=\"hidden\" id=\"rid"+id+"\" value="+restaurant_id+">");
                                    out.println("<input type=\"hidden\" id=\"pid"+id+"\" value="+rs.getString("product_id")+">");
                                    out.println("<input type=\"hidden\" id=\"cost" + id + "\" value="+rs.getInt("cost")+">");
                                    out.println("<h4 id=\"pname"+id+"\">"+rs.getString("product_name")+"</h4>");
                                    out.println("<p>Cost: "+rs.getString("cost") +"</p>");
                                    PreparedStatement stmt = myConn.prepareStatement("select quantity from "+table+" where product_id=? AND user = ?");
                                    stmt.setInt(1,product_id);
                                    stmt.setString(2,user);
                                    ResultSet r = stmt.executeQuery();
                                    out.println("<button type=\"button\" onclick='minus("+id+")' class=\"btn btn-default btn-xs minus\" aria-label=\"Left Align\">");
                                    out.println("<span class=\"glyphicon glyphicon-minus\" aria-hidden=\"true\"></span></button>");
                                    if(r.next()){
                                        out.println("<span id="+id+" >"+r.getString("quantity")+"</span>");
                                    }
                                    else{
                                        out.println("<span id="+id+" >0</span>");
                                    }
                                    out.println("<button type=\"button\" onclick='plus("+id++ +")' class=\"btn btn-default btn-xs plus\" aria-label=\"Left Align\">");
                                    out.println("<span class=\"glyphicon glyphicon-plus\" aria-hidden=\"true\"></button></span>");
                                    out.println("</div></div></div>");
                                }

                    %>
                </div>

                <div class="col-md-4">
                    <div class="thumbnail">
                        <div class="caption">
                            <h3>Cart</h3>
                            <div class="row">
                                <ul class="nav" id="cart">
                                    <%
                                            double total=0;
                                            st = myConn.prepareStatement("select product_name,cost,quantity from "+table+" where user = ?");
                                            st.setString(1,user);
                                            rs = st.executeQuery();
                                            while(rs.next()){
                                                total += (rs.getInt("cost")* rs.getInt("quantity"));
                                                out.println("<li><p>"+rs.getString("product_name")+" cost: " +rs.getInt("cost") +" quantity: "+rs.getString("quantity") +"</p></li>");
                                            }

                                    %>

                                </ul>
                            </div>
                            <div class="row">
                                <p>Total: </p>
                                <%
                                        out.println("<p class=\"pull-right\" id=\"bill\">"+total+"</p>");
                                    }catch(Exception e){
                                        e.printStackTrace();
                                    }
                                %>
                            </div>
                            <p>
                                <%
                                    if ((session.getAttribute("user") == null) || (session.getAttribute("user") == "")) {
                                %>

                                <a href="#login" data-toggle="modal" data-backdrop = "false" class = "btn btn-primary">Check out</a>

                                <%
                                    }else{
                                %>

                                <a href="Checkout.jsp" class="btn btn-primary" role="button">Check out</a>

                                <%
                                    }
                                %>

                            </p>
                        </div>
                    </div>
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
                <li>
                    <span> • </span>
                    <a href="register.html">Partner with us</a>
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
    $('#search').on('click', function() {
        var location = $('.location').val();
        if (location != undefined && location != null) {
            window.location = '/SearchHome.jsp?location=' + location;
        }
    });

    function plus(id) {
        var data=parseInt($('#'+id).html());
        $('#'+id).html(++data);
        $.post("AddCart",
            {
                productName: $('#pname'+id).html(),
                productId: $('#pid'+id).val(),
                cost: $('#cost'+id).val(),
                restaurantid: $('#rid'+id).val()

            },
            function (data) {
                var result = $.parseJSON(data);
                var options='';
                var total = 0;
                $.each(result, function(k,v){
                    total += (v.cost * v.quantity);
                    options += "<li><p>"+v.product_name+" cost: " +v.cost +" quantity: "+v.quantity +"</p></li>";
                });
                console.log(options);
                $('#cart').html(options);
                $('#bill').html(total);
            });
    }

    function minus(id) {
        var data=parseInt($('#'+id).html());
        if(data>0) {
            $('#' + id).html(--data);
            $.post("DeleteCart", {
                    productId: $('#pid' + id).val()
                },
                function (data) {
                    var result = $.parseJSON(data);
                    var total = 0;
                    var options='';
                    $.each(result, function(k,v){
                        total += (v.cost * v.quantity);
                        options += "<li><p>"+v.product_name+" cost: " +v.cost +" quantity: "+v.quantity +"</p></li>";
                    });
                    console.log(options);
                    $('#cart').html(options);
                    $('#bill').html(total);
                });
        }
    }
</script>