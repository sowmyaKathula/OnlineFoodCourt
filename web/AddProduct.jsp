<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: sowmya
  Date: 1/10/17
  Time: 2:56 PM
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
    <script src="http://malsup.github.com/jquery.form.js"></script>
    <script src="AddProductScript.js"></script>
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
                        <a href="OwnerHome.jsp" class="btn btn-primary">Home</a>
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
        <div class="col-md-offset-2 col-md-8">
            <div class="row panel">
                <div class="col-md-offset-3 col-md-6" style="padding:50px">
                    <form id="product_Form" action="RecordProduct" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label class = "control-label">Category:</label>
                            <select class="form-control" id="selectcat" name="selectcat">
                                <option value="NONE">
                                    --------- Select Any Category ---------
                                </option>
                                <%
                                    Connection myConn = null;
                                    String url = "jdbc:mysql://localhost:3306/projectforkknife";
                                    String username = "root";
                                    String password = "root";
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        myConn = DriverManager.getConnection(url, username, password);
                                        String sql="select cat,cat_id from catg where phone= '"+session.getAttribute("user")+"'";
                                        PreparedStatement st = myConn.prepareStatement(sql);
                                        ResultSet rs = st.executeQuery();
                                        while(rs.next()){
                                            out.println("<option value='"+rs.getString(2)+"' >"+rs.getString(1)+"</option>");
                                        }
                                        myConn.close();
                                    }
                                    catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class = "control-label">Sub Category:</label>
                            <select class="form-control" id="SubCat" name="SubCat">

                            </select>
                        </div>

                        <div class="form-group">
                            <label class =" control-label">Name of the Product:</label>
                            <input type="text" class="form-control" name="product_name" id="product_name" >
                        </div>

                        <div class="form-group">
                            <label class = "control-label">Description</label>
                            <input type="text" class="form-control" name="description" id="description">
                        </div>

                        <div class="form-group">
                            <label class = "control-label">Cost:</label>
                            <input type = "text" class="form-control" name="cost" id="cost">
                        </div>

                        <div class="form-group">
                            <label class = "control-label">InStock:</label>
                            <input type="text" class="form-control" name="in_stock" id="in_stock">
                        </div>

                        <div class="form-group">
                            <label class ="control-label">Type(Veg/Non-Veg)</label>
                            <select class="form-control" name="type_product" id="type_product">
                                <option value="1">Vegeterian</option>
                                <option value="0">Non-Vegeterian</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class = "control-label">Upload Image:</label>
                            <input id="fileupload" type="file" name="fileupload" />
                        </div>


                        <input type="submit" id="recordproduct" value="+ ADD Product" class="btn btn-success">
                    </form>
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
