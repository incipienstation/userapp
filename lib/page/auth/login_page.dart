import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controller/authentication_controller.dart';
import 'package:userapp/page/home.dart';
import 'package:userapp/widget/custom_elevated_button.dart';
import 'package:userapp/widget/custom_text_form_field.dart';


final auth = FirebaseAuth.instance;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('로그인'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _loginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    final controller = Get.put(AuthenticationController());
    return GetBuilder<AuthenticationController>(
      builder: (_) {
        return Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  hint: '이메일 주소를 입력해주세요',
                  onChanged: (String? value) {
                    controller.setEmail(value!);
                  },
                  validator: (String? value){
                    if (value!.isEmpty) {
                      return '공백이 들어갈 수 없습니다.';
                    } else if (!value.isEmail) {
                      return '올바른 이메일 형식이 아닙니다.';
                    } else {
                      return null;
                    }
                  },
                ),
                CustomTextFormField(
                  id: 2,
                  hint: '비밀번호를 입력해주세요',
                  onChanged: (String? value) {
                    controller.setPassword(value!);
                  },
                  validator: (String? value){
                    if (controller.userNotFoundErrorOccurred || controller.wrongPasswordErrorOccurred) {
                      return '이메일 혹은 비밀번호가 일치하지 않습니다.';
                    } else {
                      return null;
                    }
                  },
                ),
                CustomElevatedButton(
                  title: '로그인',
                  pageRoute: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: controller.email,
                          password: controller.password,
                        );
                        Get.off(() => Home());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          controller.setErrorWithType(true, 1);
                          _formKey.currentState!.validate();
                          controller.setErrorWithType(false, 1);
                        } else if (e.code == 'wrong-password') {
                          controller.setErrorWithType(true, 2);
                          _formKey.currentState!.validate();
                          controller.setErrorWithType(false, 2);
                        }
                      }
                    }
                  },
                ),
              ],
            )
        );
      },
    );
  }
}