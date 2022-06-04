package DB;





import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SimpleEmail {

  Properties emailProperties;
  Session mailSession;
  MimeMessage emailMessage;

  public static void main(String args[]) throws AddressException,
      MessagingException {

    SimpleEmail javaEmail = new SimpleEmail();

    javaEmail.setMailServerProperties();
    javaEmail.createEmailMessage();
    javaEmail.sendEmail();
  }
  public void sendMessage(String subject,String message,String to){
        try {
            SimpleEmail javaEmail = new SimpleEmail();
            javaEmail.setMailServerProperties();
            javaEmail.createEmailMessage(subject,message, to);
            javaEmail.sendEmail();
        } catch (AddressException ex) {
            Logger.getLogger(SimpleEmail.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(SimpleEmail.class.getName()).log(Level.SEVERE, null, ex);
        }
  }


  public void setMailServerProperties() {

    String emailPort = "587";//gmail's smtp port

    emailProperties = System.getProperties();
    emailProperties.put("mail.smtp.port", emailPort);
    emailProperties.put("mail.smtp.auth", "true");
    emailProperties.put("mail.smtp.starttls.enable", "true");

  }

  public void createEmailMessage() throws AddressException,
      MessagingException {
    String[] toEmails = { "colthurling@gmail.com" };
    String emailSubject = "Authentication";
    String emailBody = "This is an email sent by <b>JavaMail</b> api.";

    mailSession = Session.getDefaultInstance(emailProperties, null);
    emailMessage = new MimeMessage(mailSession);

    for (int i = 0; i < toEmails.length; i++) {
      emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
    }

    emailMessage.setSubject(emailSubject);
    emailMessage.setContent(emailBody, "text/html");//for a html email
    //emailMessage.setText(emailBody);// for a text email

  }

  public void createEmailMessage( String emailSubject ,String message,String to) throws AddressException,
      MessagingException {
    String[] toEmails = { to };
   
    String emailBody = message;

    mailSession = Session.getDefaultInstance(emailProperties, null);
    emailMessage = new MimeMessage(mailSession);

    for (int i = 0; i < toEmails.length; i++) {
      emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
    }

    emailMessage.setSubject(emailSubject);
    emailMessage.setContent(emailBody, "text/html");//for a html email
    //emailMessage.setText(emailBody);// for a text email

  }
 public void createEmailMessages(String message, String[] toEmails) throws AddressException,
      MessagingException {

    String emailSubject = "Authentication";
    String emailBody = message;

    mailSession = Session.getDefaultInstance(emailProperties, null);
    emailMessage = new MimeMessage(mailSession);

    for (int i = 0; i < toEmails.length; i++) {
      emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
    }

    emailMessage.setSubject(emailSubject);
    emailMessage.setContent(emailBody, "text/html");//for a html email
    //emailMessage.setText(emailBody);// for a text email

  }


  public void sendEmail() throws AddressException, MessagingException {

    String emailHost = "smtp.gmail.com";
    String fromUser = "trymelater111@gmail.com";//just the id alone without @gmail.com
    String fromUserEmailPassword = "qwerty@123";

    Transport transport = mailSession.getTransport("smtp");

    transport.connect(emailHost, fromUser, fromUserEmailPassword);
    transport.sendMessage(emailMessage, emailMessage.getAllRecipients());
    transport.close();
    System.out.println("Email sent successfully.");
  }

}