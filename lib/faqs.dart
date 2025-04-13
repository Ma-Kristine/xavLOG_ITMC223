import 'package:flutter/material.dart';

class FAQs extends StatelessWidget {
  const FAQs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF071D99),
        title: const Text('FAQs'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF071D99),
                ),
              ),
              const SizedBox(height: 20),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqSection(String title, List<Map<String, String>> faqs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF071D99),
            ),
          ),
        ),
        ...faqs.map((faq) => Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                title: Text(
                  faq['Q']!,
                  style: const TextStyle(
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
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}