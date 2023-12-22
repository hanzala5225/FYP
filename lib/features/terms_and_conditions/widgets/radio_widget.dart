import '../../../commons/common_imports/common_libs.dart';

class RadioWidget extends StatefulWidget {
  final Function(bool value) selectedVaueFunction;
  final bool selectedVaue;
  const RadioWidget({Key? key, required this.selectedVaue, required this.selectedVaueFunction}) : super(key: key);

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Radio(
              value: false,
              groupValue: widget.selectedVaue,
              onChanged: (val){
                setState(() {
                  widget.selectedVaueFunction(val as bool);
                });
              }
          ),
        ),
        Expanded(
          child: Text("I carefully read and agree with terms and conditions", style: getRegularStyle(
              fontSize: MyFonts.size14,
              color: MyColors.lightText2Color
          ),),
        )
      ],
    );
  }
}
