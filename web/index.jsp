<%@page import="java.sql.Connection"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <!--css-->
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <!--font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%,70% 0%,100% 0,100% 91%,63% 100%,22% 91%,0 99%,0 0);
            }
            body{
                background: url(blog_pics/bg.jpeg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>
      <!--navbar-->
      <%@include file="normal_navbar.jsp" %>
      <!--end navbar-->
       <!--banner-->
       <div class="container-fluid p-0 m-0">
            <div class="jumbotron primary-background text-white banner-background">
                <div class="container" style="padding-bottom: 80px">
                   <h3 class="display-3">Welcome To Tech Blog</h3>
                   <p>Welcome to Technical Blog, World of Technology.Welcome to Technical Blog, World of Technology.Welcome to Technical Blog, World of Technology Welcome to Technical Blog, World of Technology.Welcome to Technical Blog, World of Technology.Welcome to </p>
                   <p>Welcome to Technical Blog, World of Technology.Welcome to Technical Blog, World of Technology.Welcome to Technical Blog.</p>
                   <button class="btn btn-outline-light btn-lg"><span class="fa fa-user-plus"></span> Start ! its Free</button>
                   <a href="login_page.jsp" class="btn btn-outline-light btn-lg"> <span class="fa fa-user-circle fa-spin"></span> Login</a>
               </div>
           </div>
       </div>
       <!--end banner-->
       <!--card-->
       <div class="container" id="post-container">
           
           
       </div>
        <!--end card-->
        <script src="bootstrap/js/jquery.js" type="text/javascript"></script>
        <script src="bootstrap/js/popper.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        
        <script>
                    function getPosts(catId){
//                    $('#loader').show();
//                            $('#post-container').hide();
//                            $('.c-link').removeClass('active')
                            $.ajax({
                            url:"home_load_posts.jsp",
                                    data:{cid:catId},
                                    success: function (data, textStatus, jqXHR){
                                    console.log(data)
//                                            $('#loader').hide();
                                            $('#post-container').show();
                                            $('#post-container').html(data);
//                                            $(temp).addClass('active');
                                    }
                            })
                    }
            $(document).ready(function(e){
//            let allPostRef = $('.c-link')[0];
                    getPosts(0);
            })
        </script>
    </body>
</html>
