import 'package:flutter/material.dart';

import '../../../../resources/strings_manager.dart';

class HomeV extends StatefulWidget {
  const HomeV({super.key});

  @override
  State<HomeV> createState() => _HomeVState();
}

class _HomeVState extends State<HomeV> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.home),
    );
  }
}
