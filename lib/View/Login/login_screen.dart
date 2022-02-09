import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/ViewModel/AppStartUp/app_startup_notifier.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:gscm_store_owner/Accessories/app_button.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final loginForm = FormGroup({
    'username': FormControl<String>(
      validators: [Validators.required],
      touched: false,
    ),
    'password': FormControl<String>(
      validators: [Validators.required],
      touched: false,
    )
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset('assets/images/login-img.png'),
              ),
              _buildLoginForm(),
              const Spacer(),
              MainButton(
                  height: 50,
                  width: double.infinity,
                  bgColor: kPrimaryColor,
                  text: const Text(
                    'Tiếp tục',
                    style: TextStyle(fontSize: 20, color: kWhite),
                  ),
                  onTap: () {
                    if(loginForm.valid) {
                      debugPrint('form valid');
                      ref.read(appStartupProvider.notifier).login();
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Chưa có tài khoản?',
                    style: TextStyle(fontSize: 17),
                  ),
                  TextButton(
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return ReactiveFormBuilder(
      form: () => loginForm,
      builder: (context, formGroup, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tài khoản',
            style: kInputTitleTextStyle,
          ),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'username',
            validationMessages: (control) => {
              ValidationMessage.required: 'The username must not be empty',
            },
            decoration: kTextInputDecoration,
          ),
          const SizedBox(height: 10),
          const Text(
            'Mật khẩu',
            style: kInputTitleTextStyle,
          ),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'password',
            obscureText: true,
            validationMessages: (control) => {
              ValidationMessage.required: 'The password must not be empty',
            },
            decoration: kTextInputDecoration,
          ),
        ],
      ),
    );
  }
}
