<%@page import="com.tech.blog.dao.LikesDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Post"%>

<div class="row">

    <%
//        Thread.sleep(500);
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        int cid=Integer.parseInt(request.getParameter("cid"));
        List<Post> posts=null;
        if (cid==0){
            posts = d.getAllPosts();
        }
        else{
            posts=d.getPostByCatId(cid);
        }
        if(posts.size()==0)
        {
            out.println("<h3 class='display-3 text-center'>No Posts in this category...</h3>");
            return;
        }
        for (Post p : posts) {   
    %>

    <div class="col-md-6 mb-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <b><%=p.getpTitle()%></b>
                <p><%=p.getpContent()%></p>
            </div>
            <div class="card-footer primary-background text-center">
                <%
                    LikesDao ld = new LikesDao(ConnectionProvider.getConnection());
                %>
                <a href="#!" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=ld.countLikesOnPost(p.getPid())%></span></a> 
                <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light btn-sm">Read More...</a>
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
            </div>
        </div>
    </div>
        <%
            }
        %>
</div>