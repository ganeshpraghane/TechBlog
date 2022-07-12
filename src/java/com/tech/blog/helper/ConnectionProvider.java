package com.tech.blog.helper;

import java.sql.*;
public class ConnectionProvider {
    private static Connection con;
    public static Connection getConnection()
    {
        try {
            if(con==null)
            {
            Class.forName(DBInfo.DATABASE_DRIVER);
            con=DriverManager.getConnection(DBInfo.DATABASE_URL,DBInfo.DATABASE_USER,DBInfo.DATABASE_PASS);    
            }
            
        } catch (Exception e) {
                e.printStackTrace();
        }
        return con;
    }
}
