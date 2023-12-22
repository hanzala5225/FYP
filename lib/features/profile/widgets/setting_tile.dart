
import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/assets_manager.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key, required this.onTap, required this.buttonName,
  });
  final Function() onTap;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          child: Container(
              alignment: Alignment.center,
              height: 55.h,
              width: double.infinity,
              color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      buttonName,
                      style: getSemiBoldStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: MyFonts.size16),
                    ),

                    Image.asset(AppAssets.arrowRight,width:20.w ,height: 20.h, color: Theme.of(context).colorScheme.primary,)
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
