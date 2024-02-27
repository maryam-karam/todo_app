import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/services/snackbar_service.dart';

class FirebaseUtils{

  //To create a new user account with a password
 Future<bool> createUserAccount(String emailAddress,String password) async{
    EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user?.email);

      return Future.value(true);

    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        SnackBarService.showErrorMessage("The password provided is too weak.");

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        SnackBarService.showErrorMessage("The account already exists for that email.");

      }
      EasyLoading.dismiss();
      return Future.value(false);

    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);

    }
  }

 //The steps for signing in a user with a password
  // are similar to the steps for creating a new account.

  Future<bool>loginUserAccount(String emailAddress,String password) async{
    EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );

      print(credential.user?.uid);
      return Future.value(true);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        SnackBarService.showErrorMessage("No user found for that email");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        SnackBarService.showErrorMessage("Wrong password provided for that user.");


      }
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }
}