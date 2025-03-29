import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  String name = 'John Doe';
  String role = 'Admin';
  String contact = '+1 234 567 8900';
  String email = 'john.doe@example.com';
  String twitter = '@johndoe';
  String linkedin = 'linkedin.com/in/johndoe';



  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildTextField('Name', name, (value) => name = value),
          _buildTextField('Role', role, (value) => role = value),
          _buildTextField('Contact', contact, (value) => contact = value),
          _buildTextField('Email', email, (value) => email = value),
          _buildTextField('Twitter', twitter, (value) => twitter = value),
          _buildTextField('LinkedIn', linkedin, (value) => linkedin = value),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD7A61F),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            onPressed: _saveChanges,
            child: const Text('Save Changes', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF071D99)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit, 
              color: Color(0xFF071D99)),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFF071D99),
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF071D99),
              ),
            ),
            Text(
              role,
              style: const TextStyle(
                fontSize: 16, 
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            //Info Cards
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _isEditing ? _buildEditForm() : _buildProfileView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileView() {
    return Column(
      children: [
        _buildInfoCard('Personal Information', [
          _buildInfoTile(Icons.phone, 'Contact', contact),
          _buildInfoTile(Icons.email, 'Email', email),
        ]),
        const SizedBox(height: 16),
        _buildInfoCard('Social Media', [
          _buildInfoTile(Icons.flutter_dash, 'Twitter', twitter),
          _buildInfoTile(Icons.link, 'LinkedIn', linkedin),
        ]),
      ],
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF071D99),
              ),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}