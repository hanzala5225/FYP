import 'package:rental_app/commons/common_widgets/custom_appbar.dart';
import '../../../commons/common_imports/common_libs.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Contact Us !"),
            )
          ],
        ),
      ),
    );
  }
}
