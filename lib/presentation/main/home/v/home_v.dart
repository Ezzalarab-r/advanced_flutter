import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/domain/usecases/home_uc.dart';
import 'package:advanced_flutter/presentation/main/home/vm/home_vm.dart';
import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';

class HomeV extends StatefulWidget {
  const HomeV({super.key});

  @override
  State<HomeV> createState() => _HomeVState();
}

class _HomeVState extends State<HomeV> {
  final HomeVM _homeVM = gi<HomeVM>();

  _bind() {
    _homeVM.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _homeVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.home),
    );
  }
}
