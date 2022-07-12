<%@page import="com.tech.blog.entities.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <!--css-->
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <!--font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%,70% 0%,100% 0,100% 91%,63% 100%,22% 91%,0 99%,0 0);
            }

        </style>

    </head>
    <body>
        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>
        <main class="d-flex align-items-center primary-background banner-background" style="height:90vh">
            <div class="container" style="padding-bottom:50px">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <!--card start-->
                        <div class="card">
                            <div class="card-header primary-background text-white text-center">
                                <span class="fa fa-user-plus fa-3x"></span>
                                <br>
                                <p>Login Here</p>
                            </div>
                            <% 
                            Message m=(Message)session.getAttribute("msg");
                            if(m!=null)
                            {
                            %> 
                            <div class="alert <%=m.getCssClass()%> m-2" role="alert">
                             <%=m.getContent()%>
                            </div>
                             <% 
                                session.removeAttribute("msg");
                            }
                            %>
                         
                            <div class="card-body">
                                <form action="LoginServlet" method="post">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Email address</label>
                                        <input name="email" required type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputPassword1">Password</label>
                                        <input name="password" required type="password" class="form-control" id="exampleInputPassword1">
                                    </div>
                                    <div class="container text-center">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                            <!--card end-->
                    </div>
                </div>
            </div> 
        </main>






        <script src="bootstrap/js/jquery.js" type="text/javascript"></script>
        <script src="bootstrap/js/popper.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
