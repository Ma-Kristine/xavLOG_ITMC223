import 'package:flutter/material.dart';
import 'package:xavlogsigninpage/login_page.dart';
import 'terms_and_conditions.dart';
import 'faqs.dart'; 

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  String name = 'John Doe';
  String description = 'Student';
  String contact = '+1 234 567 8900';
  String email = 'john.doe@example.com';
  String department = 'Computer Science';
  String program = 'BS IT';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;

    // Responsive dimensions
    final fontSize = width * 0.03;
    final iconSize = width * 0.04;

    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF071D99), // Blue AppBar
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () {
            if (_isEditing) {
              setState(() {
                _isEditing = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: _isEditing
            ? const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost',
                  color: Colors.white,
                ),
              )
            : null,
        actions: _isEditing
            ? null // Remove settings icon when in edit mode
            : [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer(); // Open the settings sidebar
                    },
                  ),
                ),
              ],
      ),
      endDrawer: _isEditing ? null : _buildSettingsSidebar(), // Remove sidebar when editing
      body: SingleChildScrollView(
        child: _isEditing
            ? _buildEditForm()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: width * 0.10, // Responsive avatar size
                    backgroundColor: const Color.fromARGB(255, 146, 146, 146),
                    child: Icon(Icons.person, size: iconSize * 2, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: fontSize * 1.8,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost', // Updated font
                      color: const Color(0xFF071D99), // Blue text
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: fontSize * 1.2,
                      fontFamily: 'Jost', // Updated font
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Personal Information Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildInfoCard(
                      'Personal Information',
                      [
                        _buildInfoTile(Icons.email, 'Email', email),
                        _buildInfoTile(Icons.phone, 'Phone', contact),
                        _buildInfoTile(Icons.home_filled, 'Department', department),
                        _buildInfoTile(Icons.category, 'Program of Study', program),
                      ],
                      showEditIcon: true,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Utilities Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildInfoCard(
                      'Utilities',
                      [
                        _buildUtilityTile(Icons.rule, 'Terms and Conditions', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TermsAndConditions()),
                          );
                        }),
                        _buildUtilityTile(Icons.help, 'View FAQs', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FAQs()),
                          );
                        }),
                        _buildUtilityTile(Icons.logout, 'Log-Out', () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: const Text(
                                  'Logout',
                                  style: TextStyle(
                                    color: Color(0xFF071D99),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: const Text(
                                  'Are you sure you want to logout?',
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => const LoginPage()),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(
                                        color: Color(0xFF071D99),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildEditForm() {
    final nameController = TextEditingController(text: name);
    final contactController = TextEditingController(text: contact);
    final emailController = TextEditingController(text: email);
    final descriptionController = TextEditingController(text: description);
    final departmentController = TextEditingController(text: department);
    final programController = TextEditingController(text: program);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Name Field
            _buildTextField('Name', nameController, (value) => name = value),

            // Contact Field
            _buildTextField('Phone', contactController, (value) => contact = value),

            // Email Field
            _buildTextField('Email', emailController, (value) => email = value),

            // Description Field
            _buildTextField('Description', descriptionController, (value) => description = value),

            // Department Field
            _buildTextField('Department', departmentController, (value) => department = value),

            // Program Field
            _buildTextField('Program of Study', programController, (value) => program = value),

            const SizedBox(height: 20),

            // Save Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF071D99), // Blue button
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _saveChanges(nameController.text, contactController.text, emailController.text);
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Jost', // Updated font
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontFamily: 'Jost'), // Updated font
          filled: true,
          fillColor: const Color(0xFFF5F5F5), // Light gray background
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF071D99)), // Blue border
          ),
        ),
        style: const TextStyle(color: Colors.black, fontFamily: 'Jost'), // Updated font
        onChanged: onChanged,
      ),
    );
  }

  void _saveChanges(String updatedName, String updatedContact, String updatedEmail) {
    setState(() {
      name = updatedName;
      contact = updatedContact;
      email = updatedEmail;
      _isEditing = false;
    });
  }

  Widget _buildInfoCard(String title, List<Widget> children, {bool showEditIcon = false}) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF), // White background
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSize * 1.2, // 18 -> fontSize * 1.2
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF071D99),
                ),
              ),
              if (showEditIcon)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                  child: Icon(
                    Icons.edit, 
                    color: const Color(0xFF071D99),
                    size: fontSize * 1.2,
                  ),
                ),
            ],
          ),
          const Divider(height: 20, color: Colors.grey),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(fontSize * 0.4),
            decoration: BoxDecoration(
              color: const Color(0xFF071D99).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon, 
              color: const Color(0xFF071D99), 
              size: fontSize * 1.2,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: fontSize * 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: fontSize * 1.2, 
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUtilityTile(IconData icon, String label, VoidCallback onTap) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF071D99).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: const Color(0xFF071D99), size: 20),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize * 1.2,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSidebar() {
    return Drawer(
      backgroundColor: const Color(0xFF071D99), // Blue background
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFD7A61F), // Yellow header
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.person, size: 30, color: Color(0xFF071D99)),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.white),
            title: const Text('Account Settings', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle Account Settings action
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account Settings clicked')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.white),
            title: const Text('Notifications', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle Notifications action
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications clicked')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.white),
            title: const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle Privacy Policy action
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy Policy clicked')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('Log Out', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close the drawer first
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Color(0xFF071D99),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const Text(
                      'Are you sure you want to logout?',
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Color(0xFF071D99),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}