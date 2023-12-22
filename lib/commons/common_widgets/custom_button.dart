import '../../utils/loading.dart';
import '../common_imports/common_libs.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
    this.backColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });
  final Function()? onPressed;
  final String buttonText;
  final bool isLoading;
  final Color? backColor;
  final Color? textColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;
  final double? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? 55.h,
      margin: EdgeInsets.symmetric(vertical: padding ?? 10.h),
      child: RawMaterialButton(
        elevation: 2,
        fillColor: backColor ?? MyColors.lightThemeColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
        child: SizedBox(
          // padding: EdgeInsets.symmetric(vertical: 10.h),
          width: buttonWidth ?? 205.w,
          height: buttonHeight ?? 60.h,
          child: Center(
              child: isLoading
                  ?  const LoadingWidget(
                      color: MyColors.white
                    )
                  : Text(
                      buttonText,
                      style: getMediumStyle(
                          color: textColor ?? Colors.white,
                          fontSize: fontSize ?? MyFonts.size24,
                        isNats: true
                      ),
                    )),
        ),
      ),
    );
  }
}
