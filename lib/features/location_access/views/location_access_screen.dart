import 'package:geolocator/geolocator.dart';
import 'package:rental_app/commons/common_widgets/custom_appbar.dart';
import 'package:rental_app/commons/common_widgets/custom_button.dart';
import 'package:rental_app/utils/constants/assets_manager.dart';
import '../../../commons/common_imports/common_libs.dart';
import '../../../routes/route_manager.dart';
import '../widgets/custom_radio.dart';

class LocationAccessScreen extends StatefulWidget {
  const LocationAccessScreen({super.key});

  @override
  State<LocationAccessScreen> createState() => _LocationAccessScreenState();
}

class _LocationAccessScreenState extends State<LocationAccessScreen> {
  int selectedValue = 0;
  Position? position;

  @override
  void initState() {
    super.initState();
    initiallization();
  }

  initiallization()async{
    await determinePosition();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition();
    if (position!= null) {
    return position!;
    }else{
      return await Geolocator.getCurrentPosition();
    }
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
              Image.asset(AppAssets.whereToRentImage, width: 350.w, height: 350.h,),
              Text("Where do you want to rent products? ",
                style: getSemiBoldStyle(
                  fontSize: MyFonts.size18,
                ),),
              SizedBox(height: 12.h,),
              CustomRadio(
                  radioValue: 0,
                  selectedValue: selectedValue,
                  text: "Near Me?",
                  onChanged: (val){
                    setState(() {
                      selectedValue = val;
                    });
                  }
              ),
              CustomRadio(
                  radioValue: 1,
                  selectedValue: selectedValue,
                  text: "Other Locations",
                  onChanged: (val){
                    setState(() {
                      selectedValue = val;
                    });
                  }
              ),
              SizedBox(height: 50.h,),
              CustomButton(
                  onPressed: (){
                    Navigator.pushNamed(context, AppRoutes.signInScreen);
                  },
                  buttonText: "Continue"
              ),
            ],
          ),
        ),
      ),
    );
  }
}
