import 'package:flutter/material.dart';

class SubmissionInfoScreen extends StatelessWidget {
  const SubmissionInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submission Instructions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Submission deadline: Friday 23:59 (Date limite : 14 déc.)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '• Include only the `lib/` folder and `assets/` (if used).',
              ),
              SizedBox(height: 8),
              Text('• Include a valid SPECIFICATION.md and README.md.'),
              SizedBox(height: 8),
              Text('• Use the provided PowerShell command to create the submission zip:'),
              SizedBox(height: 8),
              SelectableText(
                'Compress-Archive -Path lib,assets -DestinationPath ..\\fit_me_app_submission.zip -Force',
                style: TextStyle(fontFamily: 'monospace'),
              ),
              SizedBox(height: 20),
              Text(
                'If you have any questions, contact the instructor before the deadline.',
              ),
              SizedBox(height: 24),
              Divider(),
              SizedBox(height: 8),
              Text(
                'Footer: Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, United States',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
