import 'dart:async';

import '../../base/base_vm.dart';
import '../../common/state_renderer/state_renderer_empl.dart';

class SearchVM extends BaseVM {
  final StreamController _emailSC = StreamController<String>.broadcast();
  final StreamController isPasswordResetLinkSent = StreamController<String>();

//   String _email = "";

//   final ForgotPasswordUC _forgotPasswordUC;

//   ForgotPasswordVM(this._forgotPasswordUC);

  @override
  void start() {
    // view model shold tell view content
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _emailSC.close();
    isPasswordResetLinkSent.close();
  }

//   // Inputs
//   //

//   @override
//   setEmail(String email) {
//     inputEmail.add(email);
//     _email = email;
//   }

//   @override
//   Sink get inputEmail => _emailSC.sink;

//   @override
//   forgotPassword() async {
//     inputState.add(
//       LoadingState(
//         stateRendererType: StateRendererType.popupLoadingState,
//         message: "Sending Reset ...",
//       ),
//     );
//     final requestResult = await _forgotPasswordUC.execute(_email);
//     requestResult.fold(
//       (failure) {
//         inputState.add(
//           ErrorState(
//             stateRendererType: StateRendererType.popupErrorState,
//             message: failure.message,
//           ),
//         );
//       },
//       (supportMessage) {
//         isPasswordResetLinkSent.add(supportMessage);
//         // Content
//         print("supportMessage");
//         print(supportMessage);
//         inputState.add(MessageState(
//           stateRendererType: StateRendererType.popupSuccess,
//           message: supportMessage,
//         ));
//       },
//     );
//   }

//   // Outputs
//   //

//   @override
//   Stream<bool> get outEmailValid =>
//       _emailSC.stream.map((email) => _isEmailValid(email));

//   bool _isEmailValid(String email) {
//     return _email.isNotEmpty;
//   }
// }

// abstract class ForgotPasswordVMInputs {
//   setEmail(String email);
//   forgotPassword();
//   Sink get inputEmail;
// }

// abstract class ForgotPasswordVMOutputs {
//   Stream<bool> get outEmailValid;
}
