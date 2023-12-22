import '../../../commons/common_imports/common_libs.dart';

class CustomRadio extends StatelessWidget {
  final int radioValue;
  final int selectedValue;
  final String text;
  final Function(int val) onChanged;
  const CustomRadio({Key? key, required this.radioValue, required this.selectedValue, required this.text, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Radio(
            value: radioValue,
            splashRadius: 1.r,
            visualDensity: VisualDensity.compact,
            groupValue: selectedValue,
            onChanged: (val){
              onChanged(val as int);
            },
            activeColor: MyColors.lightTitleColor,
            fillColor: MaterialStateProperty.all(MyColors.lightTitleColor),
          ),
        ),
        Text( text, style: getRegularStyle(color: MyColors.lightTitleColor, fontSize: MyFonts.size14),)
      ],
    );
  }
}
