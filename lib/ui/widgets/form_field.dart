
import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(dynamic? val)? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  bool autofocus  = false,
}) {
  return TextFormField(
    controller: controller,
    autofocus: autofocus ,
    obscureText: isPassword,
    onTap: () => onTap??(){},
    onChanged: (value) => onChange??(value),
    //onFieldSubmitted: (value) => onSubmit(value),
    validator: (value) {
      return validate!(value);
    },
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: () => suffixPressed,
              icon: Icon(
                suffix,
              ),
            )
          : null,
      border: OutlineInputBorder(),
    ),
  );
}
