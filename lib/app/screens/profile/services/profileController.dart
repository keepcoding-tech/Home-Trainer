import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/app/screens/profile/utilities/userData.dart';
import 'package:home_trainer/authentication/services/authenticationController.dart';

class ProfileController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 5.0,
          color: Colors.blueGrey[800],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Align(
            alignment: Alignment.topRight,
            child: MaterialButton(
              color: Colors.blueGrey[600],
              child: Text(
                'settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
              onPressed: () {
                print('open settings');
              },
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // profiel image
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 12.0,
                  left: MediaQuery.of(context).size.width / 10.0),
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/defaultUser.png'),
                  )),
            ),
            // user name
            SizedBox(height: 25.0),
            Container(
              width: 500,
              color: Colors.blueGrey[600],
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4.5),
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.blueGrey[800]),
                title: UserName(),
              ),
            ),
            // user email
            SizedBox(height: 15.0),
            Container(
              width: 500,
              color: Colors.blueGrey[600],
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4.5),
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.blueGrey[800]),
                title: UserEmail(),
              ),
            ),
          ],
        ),
        // sign out button
        Align(
          alignment: Alignment.bottomRight,
          child: MaterialButton(
            color: Colors.blueGrey[600],
            child: Text('sign Out'),
            onPressed: () {
              context.read<AuthenticationController>().signOut();
            },
          ),
        ),
      ],
    );
  }
}
