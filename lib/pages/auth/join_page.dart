import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/authentication_controller.dart';
import 'package:userapp/pages/home.dart';
import 'package:userapp/widgets/custom_elevated_button.dart';
import 'package:userapp/widgets/custom_text_form_field.dart';


final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class JoinPage extends StatelessWidget {
  JoinPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('회원가입'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _joinForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _joinForm() {
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
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '공백이 들어갈 수 없습니다.';
                    } else if (!value.isEmail) {
                      return '올바른 이메일 형식이 아닙니다.';
                    } else if (controller.duplicatedEmailErrorOccurred) {
                      return '이미 등록된 이메일 주소입니다.';
                    } else {
                      return null;
                    }
                  },
                ),
                CustomTextFormField(
                  id: 0,
                  hint: '비밀번호를 입력해주세요',
                  onChanged: (String? value) {
                    controller.setPassword(value!);
                  },
                  validator: (String? value) {
                    if (value!.length < 6) {
                      return '비밀번호는 6자리 이상이어야 합니다.';
                    } else {
                      return null;
                    }
                  },
                ),
                CustomTextFormField(
                  id: 1,
                  hint: '비밀번호를 한번 더 입력해주세요',
                  validator: (String? value) {
                    if (value != controller.password) {
                      return '입력하신 비밀번호와 다릅니다.';
                    }
                    else {
                      return null;
                    }
                  },
                ),
                CustomElevatedButton(
                    title: '회원가입',
                    pageRoute: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await auth.createUserWithEmailAndPassword(
                              email: controller.email,
                              password: controller.password
                          );
                          controller.onClose();
                          Get.offAll(() => Home());
                          _addUserDoc();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            controller.setErrorWithType(true, 0);
                            _formKey.currentState!.validate();
                            controller.setErrorWithType(false, 0);
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    }
                ),
              ],
            )
        );
      },
    );
  }

  void _addUserDoc() {
    firestore.collection('user').add({
      'uid': auth.currentUser?.uid,
      'favoriteStoreIdList': [],
    }).then((value) => null).catchError((error) => null);
  }
}