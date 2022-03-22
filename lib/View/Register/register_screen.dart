import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/app_button.dart';
import 'package:gscm_store_owner/Accessories/customed_scroll_behaviour.dart';
import 'package:gscm_store_owner/Accessories/dialog.dart';
import 'package:gscm_store_owner/Constant/app_route.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/ViewModel/AppStartUp/app_startup_notifier.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final registerform = FormGroup(
    {
      'name': FormControl<String>(
        validators: [Validators.required],
      ),
      'email': FormControl<String>(
        validators: [Validators.required],
      ),
      'phone': FormControl<String>(
        validators: [
          Validators.required,
          Validators.pattern(r'((^(\+84|84|0|0084){1})(3|5|7|8|9))+([0-9]{8})$'),
        ],
      ),
      'username': FormControl<String>(
        validators: [Validators.required],
      ),
      'password': FormControl<String>(
        validators: [
          Validators.required,
          Validators.maxLength(16),
        ],
      ),
      'confirmPassword': FormControl<String>(
        validators: [Validators.required],
      ),
    },
    validators: [Validators.mustMatch('password', 'confirmPassword')],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20),
          child: ScrollConfiguration(
            behavior: MyScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Image.asset('assets/images/register-img.png'),
                  ),
                  _buildRegisterForm(),
                  const SizedBox(height: 20),
                  MainButton(
                    height: 50,
                    width: double.infinity,
                    bgColor: kPrimaryColor,
                    text: const Text(
                      'Đăng ký',
                      style: TextStyle(fontSize: 20, color: kWhite),
                    ),
                    onTap: () async {
                      if (registerform.valid) {
                        showLoadingDialog();
                        //await Future.delayed(const Duration(seconds: 3));
                        bool result = await ref
                            .read(appStartupProvider.notifier)
                            .register(registerform.value);
                        hideDialog();
                        if (result) {
                          Fluttertoast.showToast(msg: 'Đăng ký thành công');
                          await Future.delayed(const Duration(seconds: 1));
                          Get.offAndToNamed(AppRoute.login);
                        } else {
                          Fluttertoast.showToast(msg: 'Đăng ký thất bại');
                        }
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Đã có tài khoản?',
                        style: TextStyle(fontSize: 17),
                      ),
                      TextButton(
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(
                            color: Colors.blue[300],
                            fontSize: 17,
                          ),
                        ),
                        onPressed: () {
                          Get.offAndToNamed(AppRoute.login);
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
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return ReactiveFormBuilder(
      form: () => registerform,
      builder: (context, formGroup, child) => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Text('Họ và tên'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'name',
            decoration: kTextInputDecoration,
            validationMessages: (control) =>
                {ValidationMessage.required: 'Bạn chưa nhập họ tên'},
          ),
          const SizedBox(height: 10),
          const Text('Email'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'email',
            decoration: kTextInputDecoration,
            validationMessages: (control) =>
                {ValidationMessage.required: 'Bạn chưa nhập email'},
          ),
          const SizedBox(height: 10),
          const Text('Số điện thoại'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'phone',
            decoration: kTextInputDecoration,
            validationMessages: (control) =>
                {ValidationMessage.required: 'Bạn chưa nhập số điện thoại'},
          ),
          const SizedBox(height: 10),
          const Text('Tên đăng nhập'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'username',
            decoration: kTextInputDecoration,
            validationMessages: (control) =>
                {ValidationMessage.required: 'Bạn chưa nhập tên đăng nhập'},
          ),
          const SizedBox(height: 10),
          const Text('Mật khẩu'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'password',
            decoration: kTextInputDecoration,
            obscureText: true,
            validationMessages: (control) =>
                {ValidationMessage.required: 'Bạn chưa nhập mật khẩu'},
          ),
          const SizedBox(height: 10),
          const Text('Xác nhận mật khẩu'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'confirmPassword',
            decoration: kTextInputDecoration,
            obscureText: true,
            validationMessages: (control) => {
              ValidationMessage.required: 'Bạn chưa nhập xác nhận mật khẩu',
              ValidationMessage.mustMatch:
                  'Xác nhận mật khẩu chưa trùng với mật khẩu',
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
