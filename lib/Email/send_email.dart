//import 'dart:html';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Send_Mail {
  static send_mail(String email, String message_value) async {
    String username = "pam2020se@gmail.com";
    String password = "Pam@2020";

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(email)
      ..subject = 'OTP For Email Verification'
      ..html = ""
          "<h3>$message_value</h3>"
          "";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE
    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // send the equivalent message
    //await connection.send(equivalentMessage);

    // close the connection
    await connection.close();
  }
}
