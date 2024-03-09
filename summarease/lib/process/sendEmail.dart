import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<void> sendEmail(String recipient, String subject, String body) async {
  final Email email = Email(
    recipients: [recipient],
    subject: subject,
    body: body,
  );

  try {
    await FlutterEmailSender.send(email);
    print("sent\n\n\n\n");
  } catch (error) {
    print('error: $error\n\n\n');
  }
}
