import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intern/generated/l10n.dart';
import 'package:intern/ui/views/auth/signup/signup_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../shared/ui_helper.dart';

@RoutePage()
class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    InputDecoration inputDecoration = InputDecoration(
      hintText: AppLocalizations.of(context).email,
      border: InputBorder.none,
      suffixIcon: Icon(Icons.email),
    );

    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      onViewModelReady: (viewModel) async {
        await viewModel.init();
      },
      builder:
          (BuildContext context, SignupViewModel viewModel, Widget? child) {
        return Scaffold(
          body: viewModel.isBusy
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).login_view_sign_up,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 350,
                          child: Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  UIHelper.verticalSpaceMedium(),
                                  UIHelper.verticalSpaceMedium(),
                                  Card(
                                    margin: EdgeInsets.zero,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      child: TextFormField(
                                        controller: emailController,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          viewModel.user =
                                              viewModel.user.rebuild(
                                            (p0) =>
                                                p0.email = emailController.text,
                                          );
                                        },
                                        validator: (value) {
                                          if (viewModel.validateEmail(
                                                  emailController!.text) !=
                                              null) {
                                            return AppLocalizations.of(context)
                                                .wrong_email;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: AppLocalizations.of(context)
                                              .email,
                                          border: InputBorder.none,
                                          suffixIcon: Icon(Icons.email),
                                        ),
                                      ),
                                    ),
                                  ),
                                  UIHelper.verticalSpaceMedium(),
                                  Card(
                                    margin: EdgeInsets.zero,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      child: TextFormField(
                                        controller: nameController,
                                        onChanged: (value) {
                                          viewModel.user =
                                              viewModel.user.rebuild(
                                            (p0) =>
                                                p0.name = nameController.text,
                                          );
                                        },
                                        validator: (value) {},
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context).name,
                                          border: InputBorder.none,
                                          suffixIcon: Icon(Icons.person),
                                        ),
                                      ),
                                    ),
                                  ),
                                  UIHelper.verticalSpaceMedium(),
                                  Card(
                                    margin: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: passwordController,
                                        validator: (value) {
                                          if (viewModel.validatePassword(
                                                  passwordController!.text) !=
                                              null) {
                                            return AppLocalizations.of(context)
                                                .password_must_be_more_than_6_characters_long;
                                          }
                                        },
                                        onChanged: (value) {
                                          viewModel.user =
                                              viewModel.user.rebuild(
                                            (p0) => p0.password =
                                                passwordController.text,
                                          );
                                          //passwordController.clear();
                                        },
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: AppLocalizations.of(context)
                                              .password,
                                          suffixIcon: Icon(Icons.lock),
                                        ),
                                      ),
                                    ),
                                  ),
                                  UIHelper.verticalSpaceMedium(),
                                  ElevatedButton(
                                      onPressed: () async {
                                        viewModel.signUp();
                                      },
                                      style: ButtonStyle(
                                          shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(AppLocalizations.of(context)
                                            .sign_up_view_sign),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
