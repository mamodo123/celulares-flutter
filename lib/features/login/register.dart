import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phones/features/login/functions.dart';
import 'package:phones/widgets/collumn.dart';
import 'package:provider/provider.dart';

import '../../values/validators.dart';
import '../../widgets/button.dart';
import '../../widgets/scaffold.dart';
import '../../widgets/textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? error;
  late final TextEditingController nameController,
      emailController,
      passController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      body: Builder(builder: (context) {
        final setLoading = context.watch<void Function(bool)>();

        return Form(
          key: _formKey,
          child: MyAppColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyAppTextField(
                validator: nameValidator,
                label: 'Nome',
                controller: nameController,
                keyboardType: TextInputType.name,
              ),
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
                text: 'Registrar',
                onPressed: () => tryRegister(context, setLoading),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> tryRegister(
      BuildContext context, void Function(bool) setLoading) async {
    setLoading(true);

    try {
      if (_formKey.currentState?.validate() ?? false) {
        final user = await register(
            emailController.text, passController.text, nameController.text);
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Este endereço de e-mail já está em uso.';
          break;
        case 'invalid-email':
          errorMessage = 'O endereço de e-mail não é válido.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'O registro com e-mail e senha foi desativado.';
          break;
        case 'weak-password':
          errorMessage = 'A senha fornecida é muito fraca.';
          break;
        default:
          errorMessage = 'Erro ao tentar registrar. Tente novamente.';
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
