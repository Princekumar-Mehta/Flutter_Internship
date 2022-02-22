import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Send_Mail {
  static send_mail(String email, String subject, String message_value,
      {File? file, int? isFile = 0}) async {
    String username = "pam2020se@gmail.com";
    String password = "Pam@2020";

    final smtpServer = gmail(username, password);

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(email)
      ..subject = subject
      ..attachments = isFile == 0 ? [] : [FileAttachment(file!)]
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
