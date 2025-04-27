import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../login/submit_verification_org.dart';


class ProfileOrganization extends StatefulWidget {
  const ProfileOrganization({super.key});

  @override
  State<ProfileOrganization> createState() => _ProfileOrganizationState();
}

class _ProfileOrganizationState extends State<ProfileOrganization> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFilePath;
  final TextEditingController _emailController = TextEditingController();

  Future<void> _pickPDF() async {//inserting pdf on the app
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
                                ),
                              ),
                            ),
                            SizedBox(height: 30),

                            // PDF Upload Section
                            Text(
                              'Upload Organization Documents',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF071D99),
                              ),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: _pickPDF,
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
                                        ? 'File Selected' 
                                        : 'Upload PDF File',
                                      style: TextStyle(color: Color(0xFF071D99)),
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

                            // Submit Button
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
                                  if (_formKey.currentState!.validate() && _selectedFilePath != null) {
                                    try {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VerificationPage(
                                            filePath: _selectedFilePath!,
                                            email: _emailController.text,
                                          ),
                                        ),
                                      );
                                    } catch (e) {
                                      print('Navigation error: $e'); // Add this for debugging
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error navigating to verification page')),
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
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
