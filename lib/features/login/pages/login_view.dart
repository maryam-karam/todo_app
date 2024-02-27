import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/snackbar_service.dart';
import 'package:todo_app/features/firebase_utils.dart';
import 'package:todo_app/features/layout_view.dart';

import '../../../core/widgets/custome_text_field.dart';
import '../../register/pages/register_view.dart';
import '../../settings-provider.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "login";

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFFDFECDB),
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Login",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: mediaQuery.height * 0.15),
                    Text(
                      "Welcome back!",
                      textAlign: TextAlign.start,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "E-mail",
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    CustomTextField(
                      controller: emailController,
                      hint: "Enter your e-mail address",
                      hintColor: Colors.black87,
                      suffixWidget: Icon(Icons.email_rounded),
                      keyboardType: TextInputType.emailAddress,
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter your e-mail address";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Password",
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    CustomTextField(
                      controller: passwordController,
                      isPassword: true,
                      maxLines: 1,
                      hint: "Enter your password",
                      hintColor: Colors.black87,
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter password";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 8.0),
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FirebaseUtils()
                              .loginUserAccount(
                            emailController.text,
                            passwordController.text,
                          ).then((value) {
                              if (value == true) {
                                EasyLoading.dismiss();
                                SnackBarService.showErrorMessage("successfully logged in");
                                Navigator.pushReplacementNamed(
                                    context, LayoutView.routeName);
                              }
                            },
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Login",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "OR",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RegisterView.routeName,
                            );
                          },
                          child: Text(
                            "Create new account !",
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
