
package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikesDao {
    private Connection con;
    public LikesDao(Connection con){
        this.con=con;
    }
    public boolean insertLike(int pid,int uid){
        boolean f=false;
        String query="insert into likes(pid,uid)values(?,?)";
        try {
            PreparedStatement ps=con.prepareStatement(query);
            ps.setInt(1, pid);
            ps.setInt(2, uid);
            ps.executeUpdate();
            f=true;
        } catch (Exception e){ 
            e.printStackTrace();
        }
        return f;
    }
    public int countLikesOnPost(int pid){
        int count=0;
        String query="select count(*) from likes where pid=?";
        try {
            PreparedStatement ps=con.prepareStatement(query);
            ps.setInt(1, pid);
            ResultSet set=ps.executeQuery();
            if(set.next()){
                count=set.getInt("count(*)");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    public boolean isLikedByUser(int pid,int uid){
        boolean f=false;
        String query="select * from likes where pid=? and uid=?";
        try {
            PreparedStatement ps=con.prepareStatement(query);
            ps.setInt(1, pid);
            ps.setInt(2, uid);
            ResultSet set=ps.executeQuery();
            if(set.next()){
                f=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    public boolean deleteLikes(int pid,int uid){
        boolean f=false;
        try {
            PreparedStatement ps=con.prepareStatement("delete from likes where pid=? and uid=?");
            ps.setInt(1, pid);
            ps.setInt(2, pid);
            ps.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
