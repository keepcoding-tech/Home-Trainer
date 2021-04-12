import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/authentication/services/authenticationWrapper.dart';
import 'package:home_trainer/authentication/services/authenticationController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationController>(
          create: (_) => AuthenticationController(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationController>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Home Trainer',
        theme: ThemeData(
          primaryColor: Color(0xFF1D283C),
          scaffoldBackgroundColor: Color(0xFF2B3953),
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}
