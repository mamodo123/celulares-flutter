import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../values/consts.dart';

class MyAppScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final String? error;
  final BottomNavigationBar? bottomNavigationBar;

  const MyAppScaffold(
      {super.key,
      required this.body,
      this.title = appName,
      this.error,
      this.bottomNavigationBar});

  @override
  State<MyAppScaffold> createState() => _MyAppScaffoldState();
}

class _MyAppScaffoldState extends State<MyAppScaffold> {
  @override
  Widget build(BuildContext context) {
    return LoadingProtection(
      child: widget.error == null
          ? GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(widget.title),
                  ),
                  bottomNavigationBar: widget.bottomNavigationBar,
                  body: SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: widget.body,
                  ))),
            )
          : Scaffold(
              body: Center(child: Text(widget.error!)),
            ),
    );
  }
}

class LoadingProtection extends StatefulWidget {
  final Widget child;

  const LoadingProtection({super.key, required this.child});

  @override
  State<LoadingProtection> createState() => _LoadingProtectionState();
}

class _LoadingProtectionState extends State<LoadingProtection> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Provider<void Function(bool)>.value(
      value: (bool loading) => {
        setState(() {
          this.loading = loading;
        })
      },
      child: Stack(
        children: [
          widget.child,
          if (loading)
            AbsorbPointer(
              absorbing: true,
              child: Container(
                color: Colors.white.withOpacity(0.4),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
        ],
      ),
    );
  }
}
