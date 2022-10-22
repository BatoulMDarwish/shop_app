
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/moduls/register_screen/cubit/states.dart';
import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cach_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'cubit/cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
   ShopRegisterScreen({Key? key}) : super(key: key);
  var formKey =GlobalKey<FormState>();
   var nameController=TextEditingController();
   var phoneController=TextEditingController();
   var emailController=TextEditingController();
   var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessStates)
          {
            if(state.loginModel.status==true){
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CachHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value){
                navigateAndFinish(context, const ShopLayout());
                token = state.loginModel.data!.token!;
              }).catchError((e){print(e.toString());});
            }else{
              print(state.loginModel.message);

              showToast(
                text:state.loginModel.message! ,
                state: ToastStates.ERROR,
              );
            }
          }
        },
          builder: (context,state){
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
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller:nameController ,
                          type:TextInputType.name,
                          validate: (String? value){
                            if(value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          label:'Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 15.0,),
                        defaultFormField(
                          controller:emailController ,
                          type:TextInputType.emailAddress,
                          validate: (String? value){
                            if(value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label:'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(height: 15.0,),
                        defaultFormField(
                          controller:passwordController ,
                          type:TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onSubmit: (){

                          },
                          isPassword:ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: (){
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please enter your password';
                            }
                          },
                          label:'Password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(height: 15.0,),
                        defaultFormField(
                          controller:phoneController ,
                          type:TextInputType.phone,
                          validate: (String? value){
                            if(value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                          label:'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 30.0,),


                        ConditionalBuilder(
                          condition:state is! ShopRgisterLoadingStates,
                          builder: (context) => defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email:emailController.text ,
                                    password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }

                            },

                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback:(context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
          }

      ),
    );
  }
}
