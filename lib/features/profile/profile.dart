import 'package:flutter/material.dart';
import 'package:phones/features/profile/change_name.dart';
import 'package:phones/features/providers/info.dart';
import 'package:provider/provider.dart';

import 'functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final setLoading = context.watch<void Function(bool)>();
    final info = context.watch<Info>();
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Olá, ${info.user?.name ?? 'Usuário'}!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton(
                    onPressed: () =>
                        showChangeNameDialog(context, info.user?.name ?? ''),
                    child: const Center(child: Text('Alterar nome'))),
              ],
            ),
          ),
        ),
        TextButton(
            onPressed: () => tryLogout(context, setLoading),
            child: const Center(child: Text('Sair'))),
      ],
    );
  }

  Future<void> tryLogout(
      BuildContext context, void Function(bool) setLoading) async {
    setLoading(true);
    try {
      await logout();
      if (context.mounted) {
        await Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (route) => false);
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

  Future<void> showChangeNameDialog(BuildContext context, String name) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeNameDialog(name: name);
      },
    );
  }
}
