/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DB;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

/**
 *
 * @author Er. Arpan
 */
public class SMSSender {
  public static String SMSSender(String user,String msg,String sender,String mob,String key)
    {

    //http://sms.hspsms.com/sendSMS?username=hspdemo&message=XXXXXXXXXX&sendername=XYZ&smstype=TRANS&numbers=<mobile_numbers>&apikey=d0002689-c347-4b82-af90-9d3188ad6c6e
        String rsp="";
        String retval="";
        try {
            // Construct The Post Data
            String data = URLEncoder.encode("username", "UTF-8") + "=" + URLEncoder.encode(user, "UTF-8");
            data += "&" + URLEncoder.encode("message", "UTF-8") + "=" + URLEncoder.encode(msg, "UTF-8");         
            data += "&" + URLEncoder.encode("smstype", "UTF-8") + "=" + URLEncoder.encode("PROMO", "UTF-8");
            data += "&" + URLEncoder.encode("numbers", "UTF-8") + "=" + URLEncoder.encode(mob, "UTF-8");
            data += "&" + URLEncoder.encode("apikey", "UTF-8") + "=" + URLEncoder.encode(key, "UTF-8");
               data += "&" + URLEncoder.encode("sendername", "UTF-8") + "=" + URLEncoder.encode(sender, "UTF-8");
System.out.println("http://sms.hspsms.com/sendSMS?"+data);
            //Push the HTTP Request
            URL url = new URL("http://sms.hspsms.com/sendSMS?"+data);
            URLConnection conn = url.openConnection();
            conn.setDoOutput(true);

            //OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
            //wr.write(data);
            //wr.flush();

            //Read The Response
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = rd.readLine()) != null) {
                // Process line...
                retval += line;
            }
            //wr.close();
            rd.close();

            System.out.println(retval);
            rsp = retval;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return  rsp;
    }  
}
