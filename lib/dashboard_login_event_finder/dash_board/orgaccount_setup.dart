import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart'; // Commented out for testing
import 'package:xavlogsigninpage/dashboard_login_event_finder/dash_board/org_dashboard.dart';

class ProfileOrganization extends StatefulWidget {
  const ProfileOrganization({super.key});

  @override
  State<ProfileOrganization> createState() => _ProfileOrganizationState();
}

class _ProfileOrganizationState extends State<ProfileOrganization> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFilePath; // Keep this for UI state
  final TextEditingController _emailController = TextEditingController();

  // Simplified mock function for testing
  Future<void> _pickPDF() async {
    // Commenting out actual file picking functionality
    /*
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedFilePath = result.files.single.path;
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
    */
    
    // Mock successful file selection for testing
    setState(() {
      _selectedFilePath = 'mock_document.pdf'; // Mock file path
    });
    
    // Show feedback for testing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Test file selected (Mock)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF132BB2),
                    Color(0xFF132BB2),
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Back button
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20,
                      left: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFFD7A61F),
                          size: 24,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),

                  // Logo section with fixed size
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 45, // Fixed height
                          width: 45,  // Fixed width
                          child: Image.asset(
                            'images/xavloglogo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 8), // Fixed spacing
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'xavLog',
                              style: const TextStyle(
                                color: Color(0xFFD7A61F),
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Jost',
                                fontSize: 24, // Fixed font size
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Your Campus Tether',
                              style: const TextStyle(
                                color: Color(0xFFD7A61F),
                                fontFamily: 'Jost',
                                fontSize: 12, // Fixed font size
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: constraints.maxHeight * 0.05),

                  // Main white container
                  Container(
                    width: constraints.maxWidth * 0.9,
                    constraints: BoxConstraints(
                      maxWidth: 360,
                      minHeight: constraints.maxHeight * 0.6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Center(
                              child: Text(
                                'Organization Profile',
                                style: TextStyle(
                                  color: Color(0xFF071D99),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Jost',
                                ),
                              ),
                            ),
                            SizedBox(height: 30),

                            // PDF Upload Section (UI kept for testing)
                            Text(
                              'Upload Organization Documents',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF071D99),
                                fontFamily: 'Jost',
                              ),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: _pickPDF, // Still using our mock function
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF071D99)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _selectedFilePath != null 
                                        ? Icons.check_circle 
                                        : Icons.upload_file,
                                      color: Color(0xFFD7A61F),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      _selectedFilePath != null 
                                        ? 'File Selected (Test Mode)' 
                                        : 'Upload PDF File (Test Mode)',
                                      style: TextStyle(
                                        color: Color(0xFF071D99),
                                        fontFamily: 'Jost',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 30),
                            Divider(),
                            SizedBox(height: 30),

                            // Email Section
                            Text(
                              'Moderator Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF071D99),
                                fontFamily: 'Jost',
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Enter moderator\'s email',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color(0xFF071D99)),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address';
                                }
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 40),

                            // Submit Button - Modified for testing
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFD7A61F),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  // Modified for testing - only validate email
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      // Navigate to OrgDashboard
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OrgDashboard(),
                                        ),
                                      );
                                    } catch (e) {
                                      print('Navigation error: $e');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error navigating to dashboard page')),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Please fill all required fields')),
                                    );
                                  }
                                },
                                child: Text(
                                  'Submit for Verification',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Jost',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
