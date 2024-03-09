import 'package:email_launcher/email_launcher.dart';

Future<void> sendEmail(String recipient, String subject, String body) async {
  final Email email = Email(
    to: [recipient],
    subject: subject,
    body: body,
  );
  print("Trying to send email\n\n\n");

  await EmailLauncher.launch(email);

  print("Email sent\n\n");

}
