import 'package:rental_app/commons/common_widgets/CustomTextFields.dart';
import 'package:rental_app/commons/common_widgets/custom_appbar.dart';
import 'package:rental_app/commons/common_widgets/custom_button.dart';
import '../../../commons/common_imports/apis_commons.dart';
import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/show_toast.dart';
import '../../../routes/route_manager.dart';
import '../controller/auth_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {

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
              Center(child: Text("Register", style: getMediumStyle(isNats: true, fontSize: MyFonts.size30),)),
              Text("Login to access all your saved data about items", style: getRegularStyle(
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
                          ref.read(authControllerProvider.notifier).registerWithEmailAndPassword(
                              email: emailCtr.text,
                              password: passCtr.text,
                              context: context
                          );
                        }else{
                          showToast(msg: "Fill All Fields!");
                        }
                      },
                      buttonText: "Sign-Up"
                  );
                },

              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ? ", style: getRegularStyle(color: MyColors.lightText2Color, fontSize: MyFonts.size12),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, AppRoutes.signInScreen);
                      },
                      child: Text("Login", style: getRegularStyle(color: MyColors.lightThemeColor, fontSize: MyFonts.size12),)),
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
