import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class Count extends StatefulWidget {
   int count;
  final ValueChanged<int> onChange;
  Count({required this.count,required this.onChange,super.key});

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  bool addItem = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 25,
            child: IconButton(
              padding: const EdgeInsets.all(0),
                onPressed: (){
              widget.onChange(widget.count -1);
              }, icon: const Icon(Icons.remove_circle,color: primaryColor,size: 24,)),
          ),
          BodyText(text: widget.count.toString(),fontSize: 11,fontWeight: FontWeight.bold,),
          SizedBox(
            width: 26,
            child: IconButton(
              padding: const EdgeInsets.all(0),
                onPressed: (){
              widget.onChange(widget.count+1);
            }, icon: const Icon(Icons.add_circle_outlined,color: primaryColor,size: 24,)),
          ),
        ],
      ),
    );
  }
}
