import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _user = FirebaseAuth.instance.currentUser;

  void _addContact() {
    String name = '';
    String phone = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Emergency Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => name = value,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) => phone = value,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (name.isNotEmpty && phone.isNotEmpty && _user != null) {
                await FirebaseFirestore.instance.collection('users').doc(_user!.uid).update({
                  'emergencyContacts': FieldValue.arrayUnion([
                    {'name': name, 'phone': phone}
                  ])
                });
                if (mounted) Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(100, 40)),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteContact(Map<String, dynamic> contact) async {
    if (_user != null) {
      await FirebaseFirestore.instance.collection('users').doc(_user!.uid).update({
        'emergencyContacts': FieldValue.arrayRemove([contact])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) return const Scaffold(body: Center(child: Text('Please log in')));

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Emergency Contacts', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(_user!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return _buildEmptyState();
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final contacts = (userData['emergencyContacts'] as List? ?? []);

          return Column(
            children: [
              _buildInfoBanner(),
              Expanded(
                child: contacts.isEmpty 
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index] as Map<String, dynamic>;
                        return _buildContactCard(contact);
                      },
                    ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addContact,
        icon: const Icon(Icons.person_add_rounded),
        label: const Text('Add Contact'),
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.blue.shade50,
      child: const Text(
        'These contacts will be notified when you trigger an SOS alert.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, color: Colors.blue),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('No contacts added yet', style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Colors.orange.shade50,
          child: Text(
            contact['name']?[0] ?? '?', 
            style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.bold)
          ),
        ),
        title: Text(contact['name'] ?? 'No Name', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(contact['phone'] ?? 'No Number'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
          onPressed: () => _deleteContact(contact),
        ),
      ),
    );
  }
}
