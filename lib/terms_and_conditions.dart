import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;

    // Adjusted dimensions for better fit
    final logoSize = width * 0.45; 
    final fontSize = width * 0.03; 

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF132BB2), Color(0xFFD7A61F)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        title: Text(
          'Terms And Conditions',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize * 1.5, // Adjusted font size for better readability
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'images/fulllogo.png',
                width: logoSize * 1.5, // Adjusted logo size for better fit
                height: logoSize * 1.5, 
              ),
            ),
            Text(
              'Welcome to xavLOG, a platform exclusively designed for Ateneans to monitor their academic progress, connect with fellow students, and engage in a secure online marketplace. Please read these Terms and Conditions carefully before using the xavLOG mobile or web application operated by ASCEND.\n\nBy accessing or using xavLOG, you agree to be bound by these Terms. If you disagree with any part of the Terms, please do not use the Service.',
              textAlign: TextAlign.center, // Center-align the text
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Jost',
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionCard('1. Eligibility', [
              'xavLOG is exclusively for currently enrolled students of Ateneo institutions. By using xavLOG, you confirm that you are a legitimate student with a valid school-issued email address or ID.',
            ]),
            _buildSectionCard('2. User Accounts', [
              'You are responsible for safeguarding your login credentials and for any activity under your account.',
              'You must not share your account with others or impersonate another student.',
              'Any suspicious activity may result in temporary or permanent suspension of your account.',
            ]),
            _buildSectionCard('3. Use of Services', [
              'Grades & Attendance Tracking: All academic data is manually inputted by users. xavLOG does not pull from or connect to official university records. Grades shown are for personal tracking only.',
              'Marketplace: Users may buy or sell products/services within the xavLOG marketplace. We do not facilitate payments and are not responsible for disputes or losses from transactions.',
              'Event Finder: xavLOG allows students to discover, view, and track campus events such as org fairs, academic seminars, and student activities. Event listings are submitted by users or organizations and are subject to approval. Users are expected to verify the legitimacy of events independently, and xavLOG is not liable for cancellations, changes, or disputes related to these events.',
            ]),
            _buildSectionCard('4. Content Ownership', [
              'You retain full ownership of the content you submit (e.g., marketplace listings, event posts).',
              'By uploading content, you grant xavLOG a non-exclusive license to use, display, and distribute it for functionality and promotion.',
              'You are solely responsible for ensuring your content does not violate any laws or third-party rights.',
            ]),
            _buildSectionCard('5. Prohibited Activities', [
              'You agree not to:',
              '• Use the Service for any illegal or unauthorized purpose.',
              '• Attempt to reverse-engineer, hack, or exploit the system.',
              '• Upload viruses, malware, or harmful content.',
              '• Misrepresent or falsify academic information.',
            ]),
            _buildSectionCard('6. Privacy', [
              'We respect your privacy. xavLOG only collects necessary data for verification and functionality. Your information will not be sold or shared outside the university context.',
              'For more details, please refer to our Privacy Policy.',
            ]),
            _buildSectionCard('7. Termination', [
              'We reserve the right to suspend or terminate your access to xavLOG at any time, with or without notice, for violations of these Terms or misuse of the platform.',
            ]),
            _buildSectionCard('8. Disclaimer', [
              'xavLOG is a student support tool and is not an official academic record system. Information shown is for personal reference only and should not replace official records.',
            ]),
            _buildSectionCard('9. Limitation of Liability', [
              'In no event shall xavLOG or its developers be liable for any indirect, incidental, or consequential damages arising from your use of the Service.',
            ]),
            _buildSectionCard('10. Modifications to Terms', [
              'We may update these Terms from time to time. You are responsible for reviewing the Terms regularly. Continued use of the Service after changes implies acceptance of the revised Terms.',
            ]),
            _buildSectionCard('Contact Us', [
              'For questions, concerns, or feedback about these Terms, please contact us at:',
              '📧 support@xavlog.com',
              '🌐 www.xavlog.com',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, dynamic content) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF071D99), Color(0xFF2C3E91)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: content is String
                ? Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: content.map<Widget>((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}