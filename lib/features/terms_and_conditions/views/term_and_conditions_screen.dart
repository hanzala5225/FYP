import 'package:rental_app/commons/common_widgets/custom_button.dart';
import 'package:rental_app/commons/common_widgets/show_toast.dart';
import 'package:rental_app/routes/route_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/custom_appbar.dart';
import '../widgets/radio_widget.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {

  bool selectedValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Terms & Conditions", style: getMediumStyle(
                fontSize: MyFonts.size32,
                isNats: true
              ),),
              Divider(color: MyColors.lightGreyColor, thickness: 1.h,height: 0),
              SizedBox(height: 10.h,),
              Text("Terms of use", style: getMediumStyle(fontSize: MyFonts.size16),),
              SizedBox(height: 8.h,),
              Text("Lorem Ipsum is simply dummy text  Lorem Ipsum has, Lorem Ipsum is simply dummy text oLorem Ipsum is simply dummy text  Lorem Ipsum has, Lorem Ipsum is simply dummy text oLorem Ipsum is simply dummy text  Lorem Ipsum has, Lorem Ipsum is simply dummy text oLorem Ipsum is simply dummy text  Lorem Ipsum has, Lorem Ipsum is simply dummy text oLorem Ipsum is simply dummy text  Lorem Ipsum has, Lorem Ipsum is simply dummy text oLorem Ipsum is simply dummy text  Lorem Ipsum has, Lorem Ipsum is simply dummy text oLorem Ipsum is simply dummy text  Lorem Ipsum has, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'Lorem Ipsum has been the industry' Lorem Ipsum has",
                style: getRegularStyle(fontSize: MyFonts.size12, ),),
              SizedBox(height: 30.h,),
              RadioWidget(
                selectedVaue: selectedValue,
                selectedVaueFunction: (val){
                  setState(() {
                    selectedValue = val;
                  });
                },
              ),
              SizedBox(height: 10.h,),
              Center(
                child: CustomButton(
                    onPressed: (){
                      if(selectedValue!= true){
                      Navigator.pushNamed(context, AppRoutes.onBoardingScreen);
                      }else{
                        showSnackBar(context, "Accept Terms and Conditions!");
                      }
                    },
                    buttonText: "Accept"
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
