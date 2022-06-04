package DB;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
public class Connect {


   
    
    static PreparedStatement ps = null;
    public static ResultSet rs = null;
    static String rdate = "";
    static String rtime = "";

    public static Connection openConnection() {
            Connection conn=null;
        try {
           
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/social_network","root","");
            //conn = DriverManager.getConnection("jdbc:mysql://localhost/income_tax_return?user='root'&password=");
         //  stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
          

            
           
            System.out.println("Connection done");
            rdate = getDate();
            rtime = getTime();
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return conn;
    }
   

 

  
public static  void main(String args[]){
openConnection();
}
 

    


    public static void changePass(String id, String pass) {

      Connection  conn = openConnection();
        try {
            String sql = "update tbluser set password='" + pass + "' where userid='" + id + "' ";
            ps = conn.prepareStatement(sql);//to update
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
          try {
              conn.close();
          } catch (SQLException ex) {
              Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
          }
        }
    
    }

    public static int updateField(String tblname, String field, String value, String matching_field, String matching_value) {
        int i = 0;
       Connection conn = openConnection();
        try {
            String sql = "update " + tblname + " set " + field + "='" + value + "' where " + matching_field + "='" + matching_value + "' ";
            System.out.print("sql=" + sql);
            ps = conn.prepareStatement(sql);//to update
            i = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
      finally{
          try {
              conn.close();
          } catch (SQLException ex) {
              Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
          }
        }
        return i;
    }
 public static int shareFile( String userid, String fuserid,String fileid) {
       Connection conn= openConnection();
        int i = 0;
        try {
            String sql = "insert into tblshare (userid,fuserid,fileid,rdate)values(?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, userid);
            statement.setString(2, fuserid);
            statement.setString(3, fileid);
            statement.setString(4, getDateTime());


            i = statement.executeUpdate();
        } catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
           i=2;
           e.printStackTrace();
        }catch(Exception e){
        e.printStackTrace();
        }
         finally{
          try {
              conn.close();
          } catch (SQLException ex) {
              Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
          }
        }
        return i;
    }
       public static int deleteShare(String fileid) {
        Connection conn=openConnection();
        int i = 0;
        try {
            String sql = "delete from  tblshare where fid=?";
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, fileid);
       


            i = statement.executeUpdate();
        } catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
           i=2;
           e.printStackTrace();
        }catch(Exception e){
        e.printStackTrace();
        }
      finally{
          try {
              conn.close();
          } catch (SQLException ex) {
              Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
          }
        }
        return i;
    }
    
    public static int saveLocation( String latitude, String longitude,  String userid) {
      Connection conn=  openConnection();
        int i = 0;
        try {
            String sql = "insert into tbllocation (latitude,longitude,userid,rdate)values(?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, latitude);
            statement.setString(2, longitude);
            statement.setString(3, userid);
            statement.setString(4, getDateTime());


            i = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
       finally{
          try {
              conn.close();
          } catch (SQLException ex) {
              Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
          }
        }
        return i;
    }
    public static int shareLocation( String latitude, String longitude,  String userid) {
        Connection conn=openConnection();
        int i = 0;
        try {
            String sql = "insert into tbllocation (latitude,longitude,userid,rdate)values(?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, latitude);
            statement.setString(2, longitude);
            statement.setString(3, userid);
            statement.setString(4, getDateTime());


            i = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
          try {
              conn.close();
          } catch (SQLException ex) {
              Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
          }
        }
        return i;
    }
    
    
 

    public static int saveUsers(String fname, String lname, String username,  String email,
            String address, String status, String usertype, String password, String mobile) {
       Connection conn= openConnection();
        int i = 0;
        try {
            String sql = "insert into tbluser (fname,lname,username,password,mobile_no,emailid,address,rdate,status,usertype)values(?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, fname);
            statement.setString(2, lname);
            statement.setString(3, username);
            statement.setString(4, password);
           
            statement.setString(5, mobile);
            statement.setString(6, email);
            statement.setString(7, address);
            statement.setString(8, rdate);
            statement.setString(9, status);
            statement.setString(10, usertype);

            i = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
       finally{
          try {
              conn.close();
          } catch (SQLException ex) {
              Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
          }
        }
        return i;
    }
  
    public static int saveDocument(String filename,String	filepath,String	userid) {
       Connection conn= openConnection();
        int i = 0;
        try {
          String sql="  INSERT INTO tblfiles(filename,filepath,adding_date,userid) VALUES(?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, filename);
            statement.setString(2, filepath);
            statement.setString(3, getDateTime());
            statement.setString(4, userid);
          

            i = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
          try {
              conn.close();
          } catch (SQLException ex) {
              Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
          }
        }
        return i;
    }
   

   public static int saveMessage(String message, String sent_from, String sent_to, String data_type) {

        int i = 0;
        try {
            Connection conn=openConnection();
            String sql = "insert into tblmessages (tblmessages.userid,tblmessages.fuserid,text,data_type,rdate)values(?,?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, sent_from);
            statement.setString(2, sent_to);
            statement.setString(3, message);
            statement.setString(4, data_type);
            statement.setString(5, getDateTime());


            i = statement.executeUpdate();
           
        } catch (Exception e) {
            e.printStackTrace();
        }

        return i;
    }
   public static int saveFeedback(String feedback, String fuserid, String userid) {

        int i = 0;
        try {
            Connection conn=openConnection();
            String sql = "insert into tblfeedback (feedback,userid,fuserid,rdate)values(?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, feedback);
            statement.setString(2, userid);
            statement.setString(3, fuserid);
         
            statement.setString(4, getDateTime());


            i = statement.executeUpdate();
           
        } catch (Exception e) {
            e.printStackTrace();
        }

        return i;
    }

  
 
    public static String getDateTime() {
        DateFormat dateFormat = new SimpleDateFormat(
                "yyyy/MM/dd:hh:mm:ss");

        Calendar cal = Calendar.getInstance();

        return dateFormat.format(cal.getTime());// "11/03/14 12:33:43";
    }
    public static String getFileDateTime() {
        DateFormat dateFormat = new SimpleDateFormat(
                "yyyy_MM_dd_hh_mm_ss");

        Calendar cal = Calendar.getInstance();

        return dateFormat.format(cal.getTime());// "11/03/14 12:33:43";
    }
  

    public static String getDate() {
        DateFormat dateFormat = new SimpleDateFormat(
                "yyyy/MM/dd");

        Calendar cal = Calendar.getInstance();

        return dateFormat.format(cal.getTime());// "11/03/14 12:33:43";
    }

    public static String getTime() {
        DateFormat dateFormat1 = new SimpleDateFormat(
                "HH:mm:ss");

        Calendar cal = Calendar.getInstance();

        return dateFormat1.format(cal.getTime());// "11/03/14 12:33:43";
    }
}
