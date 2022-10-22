
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/moduls/login/cubit/cubit.dart';
import 'package:shop_app/moduls/login/cubit/states.dart';
import 'package:shop_app/moduls/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

import '../../shared/components/constants.dart';
// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {

 var formKey =GlobalKey<FormState>();

   ShopLoginScreen({Key? key}) : super(key: key);

 var emailController=TextEditingController();
 var passwordController=TextEditingController();


  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) =>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state)
        {
          if(state is ShopLoginSuccessStates)
            {
              if(state.loginModel.status==true){
                print(state.loginModel.message);
                print(state.loginModel.data!.token);

                CachHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value){

                  navigateAndFinish(context, const ShopLayout());
                  token = state.loginModel.data!.token!;
                });
              }else{
                print(state.loginModel.message);

              showToast(
                  text:state.loginModel.message! ,
                   state: ToastStates.ERROR,
              );
              }
            }
        },
        builder:(context,state) =>Scaffold(
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
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller:emailController ,
                        type:TextInputType.emailAddress,
                        validate: (String? value){
                          if(value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                        label:'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(height: 15.0,),
                      defaultFormField(
                        controller:passwordController ,
                        type:TextInputType.visiblePassword,
                        suffix: ShopLoginCubit.get(context).suffix,
                        onSubmit: (){
                          if(formKey.currentState!.validate()){
                            ShopLoginCubit.get(context).userLogin(
                                email:emailController.text ,
                                password: passwordController.text);}
                        },
                        isPassword:ShopLoginCubit.get(context).isPassword,
                        suffixPressed: (){
                          ShopLoginCubit.get(context).changePasswordVisibility();
                        },
                        validate: (String? value){
                          if(value!.isEmpty){
                            return 'please enter your password';
                          }
                        },
                        label:'Password',
                        prefix: Icons.lock_outline,
                      ),
                      const SizedBox(height: 30.0,),


                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingStates,
                        builder: (context) => defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email:emailController.text ,
                                  password: passwordController.text);}

                            },

                          text: 'login',
                          isUpperCase: true,
                        ),
                        fallback:(context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(height: 15.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                          ),
                          defaultTextButton(
                            function:(){
                              navigateTo(
                                context,
                                ShopRegisterScreen(),
                              );
                            },
                            text: 'register', ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
