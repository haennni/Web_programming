package ch10;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WeblogDAO {
   final String JDBC_DRIVER = "org.h2.Driver";
   final String JDBC_URL = "jdbc:h2:tcp://localhost/~/jwbookdb";
   
   public Connection open() {
      Connection conn = null;
      try {
         Class.forName(JDBC_DRIVER);
         conn = DriverManager.getConnection(JDBC_URL,"jwbook","1234");
      } catch (Exception e) {
         e.printStackTrace();
      }
      return conn;
   }
   
   public List<Weblog> getAll() throws Exception {
      Connection conn = open();
      List<Weblog> weblogList = new ArrayList<>();
      
      String sql = "select aid, name, email, PARSEDATETIME(date,'yyyy-MM-dd') as cdate, title from weblog";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet rs = pstmt.executeQuery();
      
      try(conn; pstmt; rs) {
         while(rs.next()) {
            Weblog w = new Weblog();
            w.setAid(rs.getInt("aid"));
            w.setName(rs.getString("name"));
            w.setEmail(rs.getString("email"));
            w.setDate(rs.getString("cdate")); 
            w.setTitle(rs.getString("title"));
            
            weblogList.add(w);
         }
         return weblogList;         
      }
   }
   
   public Weblog editWeblog(int aid) throws SQLException {
      Connection conn = open();
      
      Weblog w = new Weblog();
      String sql = "select aid, name, email, PARSEDATETIME(date,'yyyy-MM-dd hh:mm:ss') as cdate, title, password, content from weblog where aid=?";
   
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, aid);
      ResultSet rs = pstmt.executeQuery();
      
      rs.next();
      
      try(conn; pstmt; rs) {
         w.setAid(rs.getInt("aid"));
         w.setName(rs.getString("name"));
         w.setEmail(rs.getString("email"));
         w.setDate(rs.getString("cdate"));
         w.setTitle(rs.getString("title"));
         w.setPassword(rs.getString("password"));
         w.setContent(rs.getString("content"));
         pstmt.executeQuery();
         return w;
      }
   }
   
   public void addWeblog(Weblog w) throws Exception {
	  Connection conn = open();
      
      String sql = "insert into weblog(name, email, title, password, content) values(?, ?, ?, ?, ?)";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      
      try(conn; pstmt) {
         pstmt.setString(1, w.getName());
         pstmt.setString(2, w.getEmail());
         pstmt.setString(3, w.getTitle());
         pstmt.setString(4, w.getPassword());
         pstmt.setString(5, w.getContent());
         pstmt.executeUpdate();
      }
   }
   
   public void delWeblog(int aid) throws SQLException {
      Connection conn = open();
      
      String sql = "delete from weblog where aid=?";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      
      try(conn; pstmt) {
         pstmt.setInt(1, aid);
         if(pstmt.executeUpdate() == 0) {
            throw new SQLException("DB에러");
         }
      }
   }
}