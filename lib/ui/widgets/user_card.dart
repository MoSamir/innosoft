import 'package:flutter/material.dart';
import 'package:innosoft/data_providers/models/User.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard({this.user});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        onTap: () {},
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text(user.userMail),
        leading: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(user.avatar),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
