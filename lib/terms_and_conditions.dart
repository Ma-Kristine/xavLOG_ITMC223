import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: const Color(0xFF071D99),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF071D99),
              ),
            ),
            const SizedBox(height: 16),
            _buildIntroduction(),
            _buildSection('1. Eligibility', [
              'xavLOG is exclusively for currently enrolled students of Ateneo institutions. By using xavLOG, you confirm that you are a legitimate student with a valid school-issued email address or ID.',
            ]),
            _buildSection('2. User Accounts', [
              'You are responsible for safeguarding your login credentials and for any activity under your account.',
              'You must not share your account with others or impersonate another student.',
              'Any suspicious activity may result in temporary or permanent suspension of your account.',
            ]),
            _buildSection('3. Use of Services', [
              'Grades & Attendance Tracking',
              'All academic data is manually inputted by users. xavLOG does not pull from or connect to official university records. Grades shown are for personal tracking only.',
              'Marketplace',
              'Users may buy or sell products/services within the xavLOG marketplace. We do not facilitate payments and are not responsible for disputes or losses from transactions.',
              'Event Finder',
              'xavLOG allows students to discover, view, and track campus events such as org fairs, academic seminars, and student activities. Event listings are submitted by users or organizations and are subject to approval. Users are expected to verify the legitimacy of events independently, and xavLOG is not liable for cancellations, changes, or disputes related to these events.',
            ]),
            _buildSection('4. Content Ownership', [
              'You retain full ownership of the content you submit (e.g., marketplace listings, event posts).',
              'By uploading content, you grant xavLOG a non-exclusive license to use, display, and distribute it for functionality and promotion.',
              'You are solely responsible for ensuring your content does not violate any laws or third-party rights.',
            ]),
            _buildSection('5. Prohibited Activities', [
              'You agree not to:',
              '• Use the Service for any illegal or unauthorized purpose.',
              '• Attempt to reverse-engineer, hack, or exploit the system.',
              '• Upload viruses, malware, or harmful content.',
              '• Misrepresent or falsify academic information.',
            ]),
            _buildSection('6. Privacy', [
              'We respect your privacy. xavLOG only collects necessary data for verification and functionality. Your information will not be sold or shared outside the university context.',
              'For more details, please refer to our Privacy Policy.',
            ]),
            _buildSection('7. Termination', [
              'We reserve the right to suspend or terminate your access to xavLOG at any time, with or without notice, for violations of these Terms or misuse of the platform.',
            ]),
            _buildSection('8. Disclaimer', [
              'xavLOG is a student support tool and is not an official academic record system. Information shown is for personal reference only and should not replace official records.',
            ]),
            _buildSection('9. Limitation of Liability', [
              'In no event shall xavLOG or its developers be liable for any indirect, incidental, or consequential damages arising from your use of the Service.',
            ]),
            _buildSection('10. Modifications to Terms', [
              'We may update these Terms from time to time. You are responsible for reviewing the Terms regularly. Continued use of the Service after changes implies acceptance of the revised Terms.',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        'Welcome to xavLOG, a platform exclusively designed for Ateneans to monitor their academic progress, connect with fellow students, and engage in a secure online marketplace. Please read these Terms and Conditions carefully before using the xavLOG mobile or web application operated by ASCEND.\n\nBy accessing or using xavLOG, you agree to be bound by these Terms. If you disagree with any part of the Terms, please do not use the Service.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> contents) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF071D99),
            ),
          ),
          const SizedBox(height: 8),
          ...contents.map((content) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}