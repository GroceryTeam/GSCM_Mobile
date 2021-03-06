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
                      '????ng k??',
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
                          Fluttertoast.showToast(msg: '????ng k?? th??nh c??ng');
                          await Future.delayed(const Duration(seconds: 1));
                          Get.offAndToNamed(AppRoute.login);
                        } else {
                          Fluttertoast.showToast(msg: '????ng k?? th???t b???i');
                        }
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '???? c?? t??i kho???n?',
                        style: TextStyle(fontSize: 17),
                      ),
                      TextButton(
                        child: Text(
                          '????ng nh???p',
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
          const Text('H??? v?? t??n'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'name',
            decoration: kTextInputDecoration,
            validationMessages: (control) =>
                {ValidationMessage.required: 'B???n ch??a nh???p h??? t??n'},
          ),
          const SizedBox(height: 10),
          const Text('Email'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'email',
            decoration: kTextInputDecoration,
            validationMessages: (control) =>
                {ValidationMessage.required: 'B???n ch??a nh???p email'},
          ),
          const SizedBox(height: 10),
          const Text('S??? ??i???n tho???i'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'phone',
            decoration: kTextInputDecoration,
            validationMessages: (control) =>
                {ValidationMessage.required: 'B???n ch??a nh???p s??? ??i???n tho???i'},
          ),
          const SizedBox(height: 10),
          const Text('T??n ????ng nh???p'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'username',
            decoration: kTextInputDecoration,
            validationMessages: (control) =>
                {ValidationMessage.required: 'B???n ch??a nh???p t??n ????ng nh???p'},
          ),
          const SizedBox(height: 10),
          const Text('M???t kh???u'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'password',
            decoration: kTextInputDecoration,
            obscureText: true,
            validationMessages: (control) =>
                {ValidationMessage.required: 'B???n ch??a nh???p m???t kh???u'},
          ),
          const SizedBox(height: 10),
          const Text('X??c nh???n m???t kh???u'),
          const SizedBox(height: 6),
          ReactiveTextField(
            formControlName: 'confirmPassword',
            decoration: kTextInputDecoration,
            obscureText: true,
            validationMessages: (control) => {
              ValidationMessage.required: 'B???n ch??a nh???p x??c nh???n m???t kh???u',
              ValidationMessage.mustMatch:
                  'X??c nh???n m???t kh???u ch??a tr??ng v???i m???t kh???u',
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
