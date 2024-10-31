import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phones/features/phones/models/phone.dart';
import 'package:phones/values/consts.dart';
import 'package:provider/provider.dart';

import 'features/home/home.dart';
import 'features/login/login.dart';
import 'features/login/register.dart';
import 'features/phones/phone.dart';
import 'features/providers/info.dart';
import 'firebase_options.dart'; // A importação do arquivo com as constantes

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider<Info>(
    create: (context) => Info(),
    child: MaterialApp(
      title: appName,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        final args = settings.arguments;

        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            );
          case '/login/register':
            return MaterialPageRoute(
              builder: (context) => const RegisterScreen(),
            );
          case '/home':
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );
          case '/home/phone':
            return MaterialPageRoute(
              builder: (context) =>
                  PhoneScreen(phone: settings.arguments as Phone),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const RouterScreen(),
            );
        }
      },
    ),
  ));
}

class RouterScreen extends StatefulWidget {
  const RouterScreen({super.key});

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadNextRoute(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<void> loadNextRoute(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (context.mounted) {
        final info = context.read<Info>();
        info.user = null;
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    } else {
      final info = context.read<Info>();
      await info.reloadUser(user.uid);
      if (context.mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      }
    }
  }
}
