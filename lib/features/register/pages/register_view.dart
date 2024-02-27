import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/firebase_utils.dart';
import 'package:todo_app/features/login/pages/login_view.dart';

import '../../../core/services/snackbar_service.dart';
import '../../../core/widgets/custome_text_field.dart';
import '../../settings-provider.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  static const String routeName = "RegisterView";
  var formKey = GlobalKey<FormState>();
  var fullNameController = TextEditingController();
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/background.png",
          ),
          fit: BoxFit.cover,
        ),
        color: Color(0xffDFECDB),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Create Account",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),

                    ///full name
                    SizedBox(
                      height: 36,
                    ),
                    Text(
                      "Full Name",
                      style: theme.textTheme.bodySmall,
                    ),
                    CustomTextField(
                      hint: "Enter your Full Name",
                      hintColor: Colors.grey.shade700,
                      keyboardType: TextInputType.emailAddress,
                      suffixWidget: Icon(Icons.person),
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter your name ";
                        }
                        return null;
                      },
                      controller: fullNameController,
                      onFieldSubmitted: (v) {
                        print(v);
                      },
                    ),

                    ///mail address
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "E-mail",
                      style: theme.textTheme.bodySmall,
                    ),
                    CustomTextField(
                      hint: "Enter your e-mail address",
                      controller: mailController,
                      hintColor: Colors.grey.shade700,
                      keyboardType: TextInputType.emailAddress,
                      suffixWidget: Icon(Icons.email),
                      onFieldSubmitted: (value) {},
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "You must enter e-mail address";
                        }

                        var reges = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                        if (!reges.hasMatch(value)) {
                          return "Invalid e-mail address";
                        }
                        return null;
                      },
                    ),

                    ///password
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Password",
                      style: theme.textTheme.bodySmall,
                    ),
                    CustomTextField(
                      isPassword: true,
                      maxLines: 1,
                      hint: "Enter your password",
                      controller: passwordController,
                      hintColor: Colors.grey.shade700,
                      suffixWidget: Icon(Icons.email_outlined),
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "You must enter your password";
                        }

                        var regex = RegExp(
                            r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");

                        if (!regex.hasMatch(value)) {
                          return "The password must include at least \n* one lowercase letter, \n* one uppercase letter, \n* one digit, \n* one special character,\n* at least 8 characters long.";
                        }
                        return null;
                      },
                    ),

                    ///confirm password
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Confirm Password",
                      style: theme.textTheme.bodySmall,
                    ),
                    CustomTextField(
                      controller: confirmPasswordController,
                      isPassword: true,
                      maxLines: 1,
                      hint: "Enter your Confirm password",
                      hintColor: Colors.grey.shade700,
                      suffixWidget: Icon(Icons.email_outlined),
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter your password";
                        }
                        if (value != passwordController.text) {
                          return "password not matched ";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FirebaseUtils()
                              .createUserAccount(
                            mailController.text,
                            passwordController.text,
                          )
                              .then((value) {
                            if (value == true) {
                              EasyLoading.dismiss();
                              SnackBarService.showErrorMessage("account successfully created");
                              Navigator.pushNamedAndRemoveUntil(context,
                                  LoginView.routeName, (route) => false);
                            }
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Create Account",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
