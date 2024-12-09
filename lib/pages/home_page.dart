import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _chatService = ChatService();
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade600,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          // TODO
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(context, userData)).toList(),
          );
        });
  }

  Widget _buildUserListItem(BuildContext context, Map<String, dynamic> userData) {
    return UserTile(
      text: userData['email'] != _authService.getCurrentUser()?.email ? userData['name'] : '${userData['name']} (You)',
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverName: userData['email'] != _authService.getCurrentUser()?.email
                    ? userData['name']
                    : '${userData['name']} (You)',
                receiverID: userData['uid'],
              ),
            ));
      },
    );
  }
}
