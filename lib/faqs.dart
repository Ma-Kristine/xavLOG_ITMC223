/// Frequently Asked Questions (FAQs)
/// 
/// Purpose: Provides users with answers to common questions about the xavLog application
/// 
/// Flow:
/// 1. User accesses FAQs from sign-in, login, or dashboard pages
/// 2. User browses categorized FAQ sections
/// 3. User can expand/collapse individual questions to view answers
/// 
/// Backend Implementation Needed:
/// - Dynamic FAQ content loading from database
/// - Analytics tracking for most viewed questions
/// - User feedback collection for FAQ usefulness
/// - Search functionality for finding specific questions
library;

import 'package:flutter/material.dart';

class FAQs extends StatelessWidget {
  const FAQs({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;

    // Calculate responsive dimensions based on screen size
    final logoSize = width * 0.45;
    final fontSize = width * 0.03;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80, 
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontFamily: 'Jost',
              color: const Color.fromARGB(255, 16, 16, 16),
              fontWeight: FontWeight.bold,
              fontSize: fontSize * 1.5,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 16, 16, 16)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App logo centered at the top
            Center(
              child: Image.asset(
                'images/fulllogo.png',
                width: logoSize * 1.5,
                height: logoSize * 1.5,
              ),
            ),
            const SizedBox(height: 5),
            
            // FAQ sections - BACKEND TODO: Load these dynamically from database
            _buildFaqSection('General Questions', [
              {
                'Q': 'What is xavLOG?',
                'A': 'xavLOG is a mobile and web application designed for Ateneo de Naga University (ADNU) students. It helps them track their academic progress, manage schedules, join social study groups, find campus events, and buy or sell items in the campus marketplace.'
              },
              {
                'Q': 'Who can use xavLOG?',
                'A': 'xavLOG is exclusively for ADNU students. You must have a valid ADNU student account to sign up and use the app.'
              },
              {
                'Q': 'Is xavLOG free to use?',
                'A': 'Yes! All xavLOG features, including the grade tracker, attendance tracker, and social collaboration tools, are free for ADNU students.'
              },
              {
                'Q': 'What platforms is xavLOG available on?',
                'A': 'xavLOG is available as a mobile app (Android and iOS) and a web application that you can access through your browser.'
              },
            ]),
            
            _buildFaqSection('Academic Features', [
              {
                'Q': 'How does the Grade Tracker work?',
                'A': 'Students manually input their scores for tasks, quizzes, and exams. The system automatically computes their current standing based on the weights of each assessment type.'
              },
              {
                'Q': 'Can I edit my grades after inputting them?',
                'A': 'Yes, you can modify or update your grades at any time. However, xavLOG does not replace the official grading system of ADNU; it only helps students monitor their academic progress.'
              },
              {
                'Q': 'How does the Attendance Tracker function?',
                'A': 'Students manually log their attendance for each subject. The system records the attendance history and provides insights into attendance trends.'
              },
              {
                'Q': 'Does xavLOG calculate my final grade for the semester?',
                'A': 'xavLOG provides an estimated grade standing based on the inputs you provide. However, your official grades will still come from ADNU\'s grading system.'
              },
            ]),
            
            _buildFaqSection('Social and Engagement Features', [
              {
                'Q': 'How do social groups work?',
                'A': 'Students can create or join study groups within the app. These groups allow students to collaborate on assignments, discuss lessons, and share academic resources.'
              },
              {
                'Q': 'Can I create private study groups?',
                'A': 'Yes, study groups can be public or private, depending on the group creator\'s settings.'
              },
              {
                'Q': 'What is the Event Finder?',
                'A': 'The Event Finder helps students discover university events, such as academic seminars, club activities, and student-led initiatives.'
              },
              {
                'Q': 'How do I join an event?',
                'A': 'You can mark yourself as "Interested" or "Attending" on an event page. Event organizers may also provide registration links if necessary.'
              },
            ]),
            
            _buildFaqSection('Marketplace and Transactions', [
              {
                'Q': 'What can I sell in the xavLOG Marketplace?',
                'A': 'Students can sell pre-owned items like books, uniforms, gadgets, and other academic-related materials.'
              },
              {
                'Q': 'How do payments work in the Marketplace?',
                'A': 'xavLOG does not process payments directly. Buyers and sellers must arrange payment and delivery independently.'
              },
              {
                'Q': 'Is there a transaction fee for using the Marketplace?',
                'A': 'No, xavLOG does not charge any transaction fees for buying or selling items.'
              },
            ]),
            
            _buildFaqSection('Technical and Security Concerns', [
              {
                'Q': 'How secure is my data on xavLOG?',
                'A': 'xavLOG follows strict security measures to protect your personal and academic data. We use encryption and secure authentication to keep your information safe.'
              },
              {
                'Q': 'Can I customize my dashboard?',
                'A': 'Yes, xavLOG allows students to personalize their dashboards by selecting what information they want to see first.'
              },
              {
                'Q': 'How do I report a bug or issue?',
                'A': 'If you encounter a problem, you can report it through the app\'s Help & Support section.'
              },
              {
                'Q': 'Can I delete my account?',
                'A': 'Yes, if you wish to delete your account, you can request account deletion through the settings page.'
              },
            ]),
            
            _buildFaqSection('Support and Contact', [
              {
                'Q': 'How can I contact the xavLOG support team?',
                'A': 'For any inquiries or technical issues, you can reach us through the Help & Support section in the app or email us at support@xavlog.com.'
              },
            ]),
            
            // BACKEND TODO: Add FAQ submission form for users to ask new questions
          ],
        ),
      ),
    );
  }

  /**
   * Builds a section of FAQs with a consistent style
   * 
   * @param title The title/category of this FAQ section
   * @param faqs List of question-answer pairs for this section
   * @return A styled Card widget containing expandable FAQ items
   */
  Widget _buildFaqSection(String title, List<Map<String, String>> faqs) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header with Xavier blue gradient
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
                fontFamily: 'Jost',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // FAQ items with expansion panels
          Container(
            color: Colors.white,
            child: Column(
              children: faqs.map((faq) {
                return ExpansionTile(
                  title: Text(
                    faq['Q']!,
                    style: const TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        faq['A']!,
                        style: const TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 14,
                          color: Color.fromARGB(188, 0, 0, 0),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}