import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phones/values/validators.dart';
import 'package:provider/provider.dart';

import '../../widgets/button.dart';
import '../../widgets/collumn.dart';
import '../../widgets/scaffold.dart';
import '../../widgets/textfield.dart';
import 'functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? error;
  late final TextEditingController emailController, passController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      error: error,
      body: Builder(builder: (context) {
        final setLoading = context.watch<void Function(bool)>();

        return Form(
          key: _formKey,
          child: MyAppColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyAppTextField(
                validator: emailValidator,
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              MyAppTextField(
                validator: passValidator,
                label: 'Senha',
                controller: passController,
                keyboardType: TextInputType.visiblePassword,
                obscure: true,
              ),
              MyAppButton(
                text: 'Entrar',
                onPressed: () => tryLogin(context, setLoading),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text('Registrar'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login/register');
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Future<void> tryLogin(
      BuildContext context, void Function(bool) setLoading) async {
    setState(() {
      setLoading(true);
    });

    try {
      if (_formKey.currentState?.validate() ?? false) {
        await login(emailController.text, passController.text);
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'O endereço de e-mail ou senha não é válido.';
          break;
        case 'invalid-email':
          errorMessage = 'O endereço de e-mail não é válido.';
          break;
        case 'user-disabled':
          errorMessage = 'Este usuário foi desativado.';
          break;
        case 'user-not-found':
          errorMessage = 'Nenhum usuário encontrado com este e-mail.';
          break;
        case 'wrong-password':
          errorMessage = 'A senha está incorreta.';
          break;
        default:
          errorMessage =
              'Ocorreu um erro ao tentar fazer login. Tente novamente.';
          break;
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro inesperado: ${e.toString()}')),
        );
      }
    } finally {
      setState(() {
        setLoading(false);
      });
    }
  }
}
