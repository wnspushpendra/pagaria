import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_state.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class Count extends StatefulWidget {
  int count;
  double? sizedBoxWidth;
  final ValueChanged<int> onChange;

  Count(
      {this.sizedBoxWidth,
      required this.count,
      required this.onChange,
      super.key});

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  bool addItem = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutBloc, CheckOutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: widget.sizedBoxWidth ?? 25,
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      widget.onChange(widget.count - 1);
                    },
                    icon: Icon(
                      Icons.remove_circle,
                      color: primaryColor,
                      size: widget.sizedBoxWidth ?? 24,
                    )),
              ),
              BodyText(
                text: widget.count.toString(),
                fontSize: widget.sizedBoxWidth != null ? 28 : 11,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                width: widget.sizedBoxWidth ?? 25,
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      widget.onChange(widget.count + 1);
                    },
                    icon: Icon(
                      Icons.add_circle_outlined,
                      color: primaryColor,
                      size: widget.sizedBoxWidth ?? 24,
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
