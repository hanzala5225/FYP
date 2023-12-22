import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/commons/common_functions/validator.dart';
import 'package:rental_app/commons/common_widgets/CustomTextFields.dart';
import 'package:rental_app/commons/common_widgets/custom_appbar.dart';
import 'package:rental_app/commons/common_widgets/custom_button.dart';
import 'package:rental_app/commons/common_widgets/show_toast.dart';
import 'package:rental_app/features/auth/controller/auth_controller.dart';
import 'package:rental_app/routes/route_manager.dart';
import '../../../commons/common_imports/common_libs.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailCtr= TextEditingController();
  final passCtr= TextEditingController();

  @override
  void dispose() {
    emailCtr.dispose();
    passCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h,),
              Center(child: Text("Login", style: getMediumStyle(isNats: true, fontSize: MyFonts.size30),)),
              Text("login to access all your saved data about items ", style: getRegularStyle(
                fontSize: MyFonts.size14,
                color: MyColors.lightText2Color
              ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60.h,),
              CustomTextField(
                  controller: emailCtr,
                  hintText: "",
                  onChanged: (val){},
                  onFieldSubmitted: (val){},
                  obscure: false,
                  label: "Email",
              ),
              SizedBox(height: 20.h,),
              CustomTextField(
                controller: passCtr,
                hintText: "",
                onChanged: (val){},
                onFieldSubmitted: (val){},
                obscure: false,
                label: "Password",
              ),
              SizedBox(height: 100.h,),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {

                  return CustomButton(
                    isLoading: ref.watch(authControllerProvider),
                      onPressed: (){
                        if(emailCtr.text.isNotEmpty && passCtr.text.isNotEmpty){
                          ref.read(authControllerProvider.notifier).loginWithEmailAndPassword(
                              email: emailCtr.text,
                              password: passCtr.text,
                              context: context
                          );
                        }else{
                          showToast(msg: "Fill All Fields!");
                        }
                      },
                      buttonText: "Login"
                  );
                },

              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account ? ", style: getRegularStyle(color: MyColors.lightText2Color, fontSize: MyFonts.size12),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, AppRoutes.signUpScreen);
                      },
                      child: Text("Sign Up", style: getRegularStyle(color: MyColors.lightThemeColor, fontSize: MyFonts.size12),)),
                ],
              ),
              SizedBox(height: 60.h,),
            ],
          ),
        ),
      ),
    );
  }
}
