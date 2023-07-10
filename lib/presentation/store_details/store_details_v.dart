import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../common/state_renderer/state_renderer_empl.dart';
import '../resources/colors_manager.dart';
import '../store_details/store_details_vm.dart';

class StoreDetailsV extends StatefulWidget {
  const StoreDetailsV({super.key});

  @override
  State<StoreDetailsV> createState() => _StoreDetailsVState();
}

class _StoreDetailsVState extends State<StoreDetailsV> {
  final StoreDetailsVM _storeDetailsVM = gi<StoreDetailsVM>();

  _bind() {
    _storeDetailsVM.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _storeDetailsVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
            stream: _storeDetailsVM.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(
                    context: context,
                    contentScreenWidget: _getContnetWidget(),
                    retryActionFunction: () {
                      _storeDetailsVM.start();
                    },
                  ) ??
                  const Center(child: Text("unknown error"));
            },
          ),
        ),
      ),
    );
  }

  Widget _getContnetWidget() {
    return Center(child: Text("details"));
    //  StreamBuilder<Object>(
    //     stream: _storeDetailsVM.outputStoreDetails,
    //     builder: (context, snapshot) {
    //       if (snapshot.data == null) {
    //         return const Center(child: Text("null data"));
    //       }
    //       // StoreDetails details = snapshot.data as StoreDetails;
    //       return Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(snapshot.data.toString()),
    //         ],
    //       );
    //     });
  }
}
