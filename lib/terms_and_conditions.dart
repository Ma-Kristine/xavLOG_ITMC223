/// Terms and Conditions Page
/// 
/// Purpose: Displays the application's terms and conditions in a formatted,
/// user-friendly layout with collapsible sections.
/// 
/// Flow:
/// 1. User navigates to this page from sign-in or login screens
/// 2. Terms are presented in organized, visually distinct sections
/// 3. User can scroll through terms and return to previous screen
/// 
/// UI Components:
/// - AppBar with back navigation
/// - Company logo
/// - Introduction text
/// - Categorized terms in card sections
/// 
/// Backend Implementation Needed:
/// - Version tracking for terms updates
/// - User acceptance status tracking
library;

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
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white, // White AppBar background
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            'Terms And Conditions',
            style: TextStyle(
              fontFamily: 'Jost', // Updated font
              color: const Color.fromARGB(255, 16, 16, 16),
              fontWeight: FontWeight.bold,
              fontSize: fontSize * 1.5, // Adjusted font size for better readability
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0), // Add padding to lower the back button
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 16, 16, 16)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        elevation: 0, // Remove shadow for a cleaner look
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
                fontFamily: 'Jost', // Updated font
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

  /// Builds a section card for terms and conditions
  /// 
  /// Creates a visually distinct card with:
  /// - A blue gradient header containing the section title
  /// - A white content area with the section details
  /// - Properly styled text for readability
  /// 
  /// @param title The title of the section displayed in the header
  /// @param content Either a string or List<String> of content items
  /// @return A styled Card widget containing the section
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
          // Blue header with gradient
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
                fontFamily: 'Jost', // Updated font
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // White background for the section content
          Container(
            color: Colors.white, // Set background to white
            padding: const EdgeInsets.all(16.0),
            child: content is String
                ? Text(
                    content,
                    style: const TextStyle(
                      fontFamily: 'Jost', // Updated font
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
                            fontFamily: 'Jost', // Updated font
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