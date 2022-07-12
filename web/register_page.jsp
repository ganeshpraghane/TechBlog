<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <!--font-awesome-->
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

        <main class="primary-background banner-background" style="padding-bottom:80px">
            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header text-center primary-background text-white">
                            <span class="fa fa-user-circle fa-3x"></span>
                            <br>
                            <p>Register Here</p>
                        </div>
                        <div class="card-body">

                            <form id="reg-form" action="RegisterServlet"  method="post">
                                <div class="form-group">
                                    <label for="user_name">User Name</label>
                                    <input name="user_name" required type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter name"/>
                                </div>

                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="user_email" required type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email"/>
                                </div>

                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="user_password" required type="password" class="form-control" id="exampleInputPassword1" placeholder="Password"/>
                                </div>

                                <div class="form-group">
                                    <label for="gender">Select Gender</label>
                                    <br>
                                    <input type="radio" id="radio" name="gender" value="male">Male
                                    <input type="radio" id="radio" name="gender" value="female">Female
                                </div>

                                <div class="form-group">
                                    <textarea name="about" class="form-control" id="about" rows="5" placeholder="Enter Something about yourself"></textarea>
                                </div>

                                <div class="form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">agree terms and conditions</label>
                                </div>
                                <div class="container text-center" id="loader" style="display: none;">
                                    <span class="fa fa-refresh fa-spin fa-3x"></span>
                                    <h4>Please wait...</h4>
                                </div>
                                <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>




        <!--javascript-->
        <script src="bootstrap/js/jquery.js" type="text/javascript"></script>
        <script src="bootstrap/js/popper.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script>
                    $(document).ready(function () {
            console.log("loaded....")
                    $('#reg-form').on('submit', function (event) {
            event.preventDefault();
                    let form = new FormData(this);
                    $("#submit-btn").hide();
                    $("#loader").show();
//                send register servlet
                    $.ajax({
                    url: "RegisterServlet",
                            type: 'POST',
                            data: form,
                            success: function (data, textStatus, jqXHR) {
                            console.log(data)

                                    $("#submit-btn").show();
                                    $("#loader").hide();
                                    if (data.trim() == 'done!')
                            {
                            swal("Registered Successfully... we redirecting to login page")
                                    .then((value) = > {
                                    window.location = "login_page.jsp"
                                    });
                            }
                            else
                            {
                            swal(data)
                            }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                            swal("Something went wrong... try  again");
                                    $("#submit-btn").show();
                                    $("#loader").hide();
                            },
                            processData: false,
                            contentType: false
                    });
            });
            });
        </script>


    </body>
</html>
