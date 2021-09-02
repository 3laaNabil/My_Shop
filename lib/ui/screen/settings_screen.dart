import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/business_logic/cubit/shop_cubit.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/ui/styles/colors.dart';
import 'package:shop_app/ui/widgets/form_field.dart';

import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  //const SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var model = ShopCubit.get(context).userModel;
    nameController.text = model!.data!.name!;
    emailController.text = model.data!.email!;
    phoneController.text = model.data!.phone!;
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    ShopCubit.get(context).userModel != null,
                widgetBuilder: (context) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/profile.png',
                            height: 170,
                            width: 200,
                          ),

                          if(state is ShopLoadingUpdateUserState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'name must not be empty';
                                }

                                return null;
                              },
                              label: 'Name',
                              prefix: Icons.person),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Email must not be empty';
                                }

                                return null;
                              },
                              label: 'Email',
                              prefix: Icons.mail),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'phone number must not be empty';
                                }

                                return null;
                              },
                              label: 'Phone Number',
                              prefix: Icons.phone),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate())
                                  ShopCubit.get(context).updateUserData(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text);
                              },
                              child: const Text(
                                'UPDATE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                signOut(context);
                              },
                              child: const Text(
                                'LOG OUT',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                fallbackBuilder: (context) =>
                    Center(child: CircularProgressIndicator())),
          ),
        );
      },
    );
  }
}
