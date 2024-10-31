import 'package:flutter/material.dart';
import 'package:phones/values/validators.dart';
import 'package:phones/widgets/button.dart';
import 'package:provider/provider.dart';

import '../../widgets/scaffold.dart';
import '../providers/info.dart';
import 'functions.dart';

class ChangeNameDialog extends StatelessWidget {
  final TextEditingController nameController;
  final _formKey = GlobalKey<FormState>();

  ChangeNameDialog({super.key, required String name})
      : nameController = TextEditingController(text: name);

  @override
  Widget build(BuildContext context) {
    return LoadingProtection(
      child: Builder(builder: (context) {
        final setLoading = context.watch<void Function(bool)>();
        return AlertDialog(
          title: const Text('Alterar Nome'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Novo Nome',
                  ),
                  validator: nameValidator,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            MyAppButton(
              onPressed: () => tryChangeName(context, setLoading),
              text: 'Salvar',
            ),
          ],
        );
      }),
    );
  }

  Future<void> tryChangeName(
      BuildContext context, void Function(bool) setLoading) async {
    if (_formKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        final name = nameController.text;
        final uid = await changeName(name);
        if (context.mounted) {
          final info = context.read<Info>();
          await info.reloadUser(uid);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro inesperado: ${e.toString()}')),
          );
        }
      } finally {
        setLoading(false);
      }
    }
  }
}
