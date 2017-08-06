<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: sowmya
  Date: 1/18/17
  Time: 9:12 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
                            if ((session.getAttribute("user") == null) || (session.getAttribute("user") == "")) {
                        %>
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#login" data-backdrop="false">Login\Register</button>
                        <%
                        } else {
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
                <input class="btn btn-default" id="search" type="submit"><i class="glyphicon glyphicon-search"></i></input>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid main">

    <div class="row">
        <div class="col-md-offset-2 col-md-8">
             <div class="row panel">
            <%
                String location = request.getParameter("location");
                Connection myConn = null;
                String url = "jdbc:mysql://localhost:3306/projectforkknife";
                String username = "root";
                String password = "root";
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    myConn = DriverManager.getConnection(url, username, password);
                    String sql="select restaurant_name,image,phone from restaurant where location like '%"+location+"%'";
                    PreparedStatement st = myConn.prepareStatement(sql);
                    ResultSet rs = st.executeQuery();
                    while(rs.next()){
                        out.println("<div class='col-sm-6 col-md-4'>");
                        out.println("<a href=\"Restaurant.jsp?restaurant_id="+rs.getString("phone")+"\"><div class='thumbnail'>");
                        out.println("<img src=\""+rs.getString(2)+"\">");
                        out.println("<div class=\"caption\">\n" +"<h3>"+rs.getString(1)+"</h3>");
                        out.println("<input type=\"submit\" id=\"viewRestaurant\" value=\"View\" class=\"btn btn-success\">");
                        out.println("</div></div></a></div>");
                    }
                    myConn.close();
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            %>
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
    })
</script>
