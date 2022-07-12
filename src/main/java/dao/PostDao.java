package dao;

import entities.Category;
import entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList<Category>();
        try {
            String q = "select * from categories";
            Statement st = con.createStatement();
            ResultSet set = st.executeQuery(q);
            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category c = new Category(cid, name, description);
                list.add(c);
            }
        } catch (Exception e) {
        }

        return list;
    }

    public boolean savePost(Post p) {
        boolean f = false;
        try {
            String q = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId)values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            pstmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
//    get all the posts

    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();
//        fetch all the posts
        try {
            PreparedStatement p=con.prepareStatement("select * from posts order by pid desc");
            ResultSet s=p.executeQuery();
            while(s.next())
            {
               int pid=s.getInt("pid");
               String pTitle=s.getString("pTitle");
               String pContent=s.getString("pContent");
               String pCode=s.getString("pCode");
               String pPic=s.getString("pPic");
               Timestamp date=s.getTimestamp("pDate");
               int catId=s.getInt("catId");
               int userId=s.getInt("userId");
               Post post=new Post(pid, catId, pTitle, pContent, pCode, pPic, date, userId);
               list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Post> getPostByCatId(int catId){
        List<Post> list = new ArrayList<>();
//        fetch all the posts by Id
        try {
            PreparedStatement p=con.prepareStatement("select * from posts where catId=?");
            p.setInt(1, catId);
            ResultSet s=p.executeQuery();
            while(s.next())
            {
               int pid=s.getInt("pid");
               String pTitle=s.getString("pTitle");
               String pContent=s.getString("pContent");
               String pCode=s.getString("pCode");
               String pPic=s.getString("pPic");
               Timestamp date=s.getTimestamp("pDate");
               int userId=s.getInt("userId");
               Post post=new Post(pid, catId, pTitle, pContent, pCode, pPic, date, userId);
               list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public Post getPostByPostId(int postId){
        Post post=null;
        String query="select * from posts where pid=?";
        try {
            PreparedStatement p=con.prepareStatement(query);
            p.setInt(1,postId);
            ResultSet set=p.executeQuery();
            if(set.next()){
              int pid=set.getInt("pid");
               String pTitle=set.getString("pTitle");
               String pContent=set.getString("pContent");
               String pCode=set.getString("pCode");
               String pPic=set.getString("pPic");
               Timestamp date=set.getTimestamp("pDate");
               int catId=set.getInt("catId");
               int userId=set.getInt("userId");
               post=new Post(pid, catId, pTitle, pContent, pCode, pPic, date, userId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }
}
