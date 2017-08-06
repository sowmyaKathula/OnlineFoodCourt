<%@ page import="java.sql.*" %><%--

  Created by IntelliJ IDEA.
  User: sowmya
  Date: 1/9/17
  Time: 11:33 AM
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
    <script src="OwnerHomeScript.js"></script>
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
                <div class="col-md-6">
                    <div class="thumbnail">

                        <%
                            Connection myConn = null;
                            String url = "jdbc:mysql://localhost:3306/projectforkknife";
                            String username = "root";
                            String password = "root";
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                myConn = DriverManager.getConnection(url, username, password);
                                String sql="select restaurant_name,image from restaurant where phone= '"+session.getAttribute("user")+"'";
                                PreparedStatement st = myConn.prepareStatement(sql);
                                ResultSet rs = st.executeQuery();
                                if(rs.next()){
                                    System.out.println("--------->"+rs.getString("restaurant_name"));
                                    if(rs.getString("image")==null) {
                                        System.out.println("true");
                                        out.println("<img src='restaurant.jpg'>");
                                    }
                                    else
                                        out.println("<img src='"+rs.getString("image")+"'>");
                                    out.println("<div class=\"caption\">");
                                    out.println("<h3>"+rs.getString("restaurant_name")+"</h3></div>");
                                }
                                myConn.close();
                            }
                            catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                        <a href="#image" data-toggle="modal" data-backdrop = "false" class = "btn">Edit Restaurant Image</a>

                        <!-- MOdal  for Image Uploading-->
                        <div class = "modal fade" id="image" role="dialog">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form id="upload_image" action="UploadImage" method="post" enctype="multipart/form-data">

                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            <h4 align=center>Upload Image</h4>
                                        </div>
                                        <div class = "model-body">
                                            <div class="form-group">
                                                <input type="file" class="form-control" name="file">
                                            </div>
                                            <button id="upload" type="submit" class="btn btn-success">Upload</button>
                                        </div>

                                    </form>
                                </div>

                            </div>
                        </div>
                        <!-- End of the modal -->

                    </div>
                </div>
                <div class="col-md-6 panel" style="padding: 30px">

                    <div class="row">
                        <div class="col-md-6 col-sm-6" align="center">
                            <a href="AddSubCat.jsp">
                                <img src="add.png" class="img-circle" width="140px" height="140px">
                            </a>
                            <h5>Add Sub Category</h5>
                        </div>
                        <div class="col-md-6 col-sm-6" align="center">
                            <a href="EditProduct.jsp">
                                <img src="edit.png" class="img-circle" width="140px" height="140px">
                            </a>
                            <h5>Edit Product</h5>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-6" align="center">
                            <a href="ViewAllProducts.jsp">
                                <img src="view.png" class="img-circle" width="140px" height="140px">
                            </a>
                            <h5>View All Products</h5>
                        </div>
                        <div class="col-md-6 col-sm-6" align="center">
                            <a href="AddProduct.jsp">
                                <img src="add.png" class="img-circle" width="140px" height="140px">
                            </a>
                            <h5>Add Product</h5>
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
