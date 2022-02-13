import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/authentication_controller.dart';

// typedef Validator = String? Function(String? value);

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final validator;
  final onChanged;
  final id;

  CustomTextFormField({Key? key, required this.hint, this.validator, this.onChanged, this.id})
      : super(key: key);

  final controller = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: hint.contains("비밀번호") ? !controller.isVisibleList[id] : false,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: hint.contains("비밀번호") ? VisibilityButton(id: id,) : null,
          hintText: "$hint",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.redAccent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.redAccent, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.redAccent)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.redAccent, width: 2)),
        ),
      ),
    );
  }
}

class VisibilityButton extends StatelessWidget {
  final id;

  VisibilityButton({
    Key? key, this.id,
  }) : super(key: key);


  final controller = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      builder: (_) {
        return SizedBox(
          height: 20,
          width: 20,
          child: IconButton(
            color: Colors.black45,
            padding: EdgeInsets.all(8),
            iconSize: 20,
            onPressed: (){
              controller.setVisibility(id);
            },
            icon: controller.isVisibleList[id]? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          ),
        );
      },
    );
  }
}
