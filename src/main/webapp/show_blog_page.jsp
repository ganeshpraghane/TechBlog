<%@page import="com.tech.blog.dao.LikesDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }

%>
<%  
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostByPostId(postId);

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=p.getpTitle()%> || TechBlog By Ganesh</title>
        <!--css-->
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <!--font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            body{
                background: url(blog_pics/bg.jpeg);
                background-size: cover;
                background-attachment: fixed;
            }
            .banner-background{
                clip-path: polygon(30% 0%,70% 0%,100% 0,100% 91%,63% 100%,22% 91%,0 99%,0 0);
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-size: 20px;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }

        </style>

    </head>
    <body>
        <!--navbar start-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="index.jsp"><span class="fa fa-asterisk"></span> Tech Blog <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp"><span class="fa fa-bell-o"></span> Learn code online</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-check-square-o"></span> Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming</a>
                            <a class="dropdown-item" href="#">project Implementation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span> Contact</a>
                    </li>  
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#Add-Post-Modal"><span class="fa fa-asterisk"></span> Do Post</a>
                    </li>  
                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile_page"><span class="fa fa-user-circle"></span> <%=user.getName()%></a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span> Logout</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!--navbar end-->

        <!--main content of body--> 
        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header primary-background text-white">
                            <h4 class="post-title"><%=p.getpTitle()%></h4>
                        </div>
                        <div class="card-body">
                            <img class="card-img-top my-2" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">

                            <div class="row my-3 row-user">
                                <div class="col-md-8">
                                    <%
                                        UserDao userdao = new UserDao(ConnectionProvider.getConnection());
                                    %>
                                    <p class="post-user-info"><a href="#!"><%= userdao.getUserByUserId(p.getUserId()).getName()%></a> has posted</p>  
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date"><%=DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                                </div>

                            </div>

                            <p class="post-content"><%=p.getpContent()%></p>
                            <br>
                            <br>
                            <div class="post-code"> 
                                <pre><%=p.getpCode()%></pre>
                            </div>
                        </div>
                        <div class="card-footer primary-background">
                            <%
                                LikesDao ld = new LikesDao(ConnectionProvider.getConnection());
                            %>
                            <a href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>,this)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=ld.countLikesOnPost(p.getPid())%></span></a>
                            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!--end of main content of body-->

        <!--modal start-->
        <!-- User Modal -->
        <div class="modal fade" id="profile_page" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%=user.getProfile()%>" class="img-fluid" style="border-radius: 50%;max-width: 150px;">
                            <br>
                            <h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5> 
                            <!-- profile details-->
                            <div id="profile-details">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th scope="row">ID:</th>
                                            <td><%=user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email:</th>
                                            <td><%=user.getEmail()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Gender:</th>
                                            <td><%=user.getGender().toUpperCase()%></td> 
                                        </tr>
                                        <tr>
                                            <th scope="row">Status:</th>
                                            <td><%=user.getAbout()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Registered on:</th>
                                            <td><%=user.getDateTime()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--end profile details-->
                            <!--profile edit-->
                            <div id="profile-edit" style="display:none;">
                                <h3 class="mt-2">Please Edit Carefully</h3>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table"> 
                                        <tr>
                                            <th>ID :</th>
                                            <td><%=user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th>Name :</th>
                                            <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"/></td>
                                        </tr>
                                        <tr>
                                            <th>Email :</th>
                                            <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"/></td>
                                        </tr>
                                        <tr>
                                            <th>Password :</th>
                                            <td><input type="text" class="form-control" name="user_password" value="<%=user.getPassword()%>"/></td>
                                        </tr>
                                        <tr>
                                            <th>Gender :</th>
                                            <td><%=user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <th>About :</th>
                                            <td><textarea class="form-control" rows="2" name="user_about"><%=user.getAbout()%></textarea></td>
                                        </tr>
                                        <tr>
                                            <th>New Profile:</th>
                                            <td>
                                                <input type="file" name="image" class="form-control"/>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!--User modal end-->
        <!--Add Post Modal-->
        <div class="modal fade" id="Add-Post-Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide The post details...</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" action="AddPostServlet" method="post">
                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>---Select Category---</option>
                                    <%
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategories();
                                        for (Category c : list) {
                                    %>
                                    <option value="<%=c.getCid()%>"><%=c.getName()%></option>
                                    <%
                                        }
                                    %>                 
                                </select>
                            </div>
                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="Enter post title" class="form-control"/>
                            </div>  
                            <div class="form-group">
                                <textarea name="pContent" class="form-control" style="height:200px;" placeholder="Enter your content"></textarea>
                            </div>    
                            <div class="form-group">
                                <textarea name="pCode" class="form-control" style="height:200px;" placeholder="Enter your program(if any)"></textarea>
                            </div> 
                            <div class="form-group">
                                <label>Select Your Pic</label>
                                <br>
                                <input type="file" name="pic"/>
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        <!--End Add Post Modal-->

        <script src="bootstrap/js/jquery.js" type="text/javascript"></script>
        <script src="bootstrap/js/popper.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script>
                                        $(document).ready(function () {
                                let editStatus = false;
                                        $('#edit-profile-button').click(function () {
                                //                    alert("button clicked")
                                if (editStatus == false)
                                {
                                $('#profile-details').hide();
                                        $('#profile-edit').show();
                                        editStatus = true;
                                        $(this).text("Back")
                                }
                                else
                                {
                                $('#profile-details').show();
                                        $('#profile-edit').hide();
                                        editStatus = false;
                                        $(this).text("Edit")
                                }
                                })
                                });</script>
        <!--now add post js-->
        <script>
                    $(document).ready(function(){
            $("#add-post-form").on("submit", function(event){
            //                    this cod get called when form is submitted
            event.preventDefault();
                    console.log("submitted");
                    let form = new FormData(this);
                    //                    now requesting to server
                    $.ajax({
                    url:"AddPostServlet",
                            type:'POST',
                            data:form,
                            success: function (data, textStatus, jqXHR) {
                            //                        success
                            console.log(data);
                                    if (data.trim() == 'done')
                            {
                            swal("Good Job", "Saved Successfully", "success");
                            }
                            else{
                            swal("Error!!", "Something went wrong try again...", "error");
                            }
                            },
                            error: function (jqXHR, textStatus, errorThrown){
                            //                          error 
                            swal("Error!!", "Something went wrong try again...", "error");
                            },
                            processData:false,
                            contentType:false
                    })
            })
            })
        </script>
    </body>
</html>
