import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/business_logic/conditional_builder.dart';
import 'package:shop_app/business_logic/cubit/register_cubit.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/ui/widgets/form_field.dart';

import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var mailController = TextEditingController();

    var passController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
  create: (context) => RegisterCubit(),
  child: BlocConsumer<RegisterCubit, ShopRegisterStates>(
  listener: (context, state) {
    if (state is ShopRegisterSuccessState) {
      if (state.registerModel.status!) {
        print(state.registerModel.message);
        // Fluttertoast.showToast(
        //     msg: state.loginModel.message.toString(),
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 5,
        //     backgroundColor: Colors.green,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        CacheHelper.saveData(
          key: 'token',
          value: state.registerModel.data!.token,
        ).then((value)


        {
          token = state.registerModel.data!.token;
          navigatToFinish(context, HomeScreen());
        });

        navigatToFinish(context, HomeScreen());
      } else {
        print(state.registerModel.message);

        Fluttertoast.showToast(
            msg: state.registerModel.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  },
  builder: (context, state) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 100,
                            scale: 1.0,
                            alignment: Alignment.topCenter,
                          )),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "REGISTER",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.topCenter,
                      //   child: Text(
                      //     'login now to browse hot offers',
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .bodyText2!
                      //         .copyWith(color: Colors.grey),
                      //   ),
                      // ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return '*please enter your Email';
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          controller: mailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return '*please enter your Email';
                            }
                          },
                          label: 'Email',
                          prefix: Icons.email),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passController,
                        type: TextInputType.visiblePassword,
                        suffix: RegisterCubit.get(context).suffix,
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '*please enter your password';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.password,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).userRegister(
                              name: nameController.text.trim(),
                              phone: phoneController.text.trim(),

                              email: mailController.text.trim(),
                              password: passController.text.trim(),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return '*please enter your Email';
                            }
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  email: mailController.text,
                                  password: passController.text,
                                );

                               token = CacheHelper.getData(key: 'token');
                              }
                            },
                            child: Text('LOGIN'),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         'Don\'t have an account?',
                      //       ),
                      //       TextButton(
                      //           onPressed: () {
                      //             navigatTo(context, RegisterScreen());
                      //           },
                      //           child: Text('register'))
                      //     ]),
                    ]),
              ),
            ),
          ),
        ));
  },
),
);
  }
}
