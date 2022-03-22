import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gscm_store_owner/Accessories/dialog.dart';
import 'package:gscm_store_owner/Constant/app_route.dart';

import 'package:gscm_store_owner/Utils/api_client.dart';
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
                onTap: () async {
                  if (loginForm.valid) {
                    String username = loginForm.control('username').value;
                    String password = loginForm.control('password').value;
                    try {
                      showLoadingDialog();
                      bool result = await ref
                          .read(appStartupProvider.notifier)
                          .login(username, password);
                      hideDialog();
                      if (result) {
                        Get.back();
                      } else {
                        throw WrongUsernamePasswordException();
                      }
                    } on WrongUsernamePasswordException {
                      Fluttertoast.showToast(msg: 'Tên đăng nhập hoặc mật khẩu không đúng');
                    }
                  }
                },
              ),
              const SizedBox(height: 12),
              MainButton(
                height: 50,
                width: double.infinity,
                bgColor: kNeutralColor100,
                hasBorder: true,
                text: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Đăng nhập bằng Google',
                      style: TextStyle(fontSize: 19, color: kBlack),
                    ),
                    const SizedBox(width: 8),
                    FaIcon(FontAwesomeIcons.google, color: kDangerColor),
                  ],
                ),
                onTap: () async {
                  await ref.read(appStartupProvider.notifier).loginFirebase();
                  Get.back();
                },
              ),
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
                    onPressed: () {
                      Get.offAndToNamed(AppRoute.register);
                    },
                    style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory),
                  ),
                ],
              ),
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
              ValidationMessage.required: 'Bạn chưa điền tên đăng nhập',
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
              ValidationMessage.required: 'Bạn chưa nhập mật khẩu',
            },
            decoration: kTextInputDecoration,
          ),
        ],
      ),
    );
  }
}
