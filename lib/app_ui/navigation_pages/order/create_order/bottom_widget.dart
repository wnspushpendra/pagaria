import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class BottomWidget extends StatefulWidget {
  List<String> selectedProduct;
  Function onClick;

   BottomWidget({required this.selectedProduct,required this.onClick,super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
          decoration: defaultDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BodyText(
                        text: 'Total item :',
                      ),
                      BodyText(
                        text: widget.selectedProduct.length.toString(),
                        color: primaryColor,
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyText(
                        text: 'Total price : ',
                      ),
                      BodyText(
                        text: ' 30000',
                        color: primaryColor,
                      ),
                    ],
                  )
                ],
              ),
              CustomButton(
                  buttonText: 'view',
                  buttonWidth: 110,
                  buttonHeight: 30,
                  radius: 15,
                  margin: 0,
                  buttonTextSize: 14,
                  onClick: () => widget.onClick())
            ],
          ),
        ));
  }

  /// ************** bottom sheet for filters **********************

  void showSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1), spreadRadius: 2),
                ]),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Space(
                    height: 10,
                  ),
                  const HeadingText(text: 'Product'),
                  const Space(
                    height: 8,
                  ),
                  ListView.builder(itemBuilder: (context, index) {
                    return Container(
                      color: Colors.red,
                      height: 10,
                    );
                  }),
                  const Space(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                            buttonText: 'Place Order',
                            buttonTextSize: 11,
                            buttonHeight: 40,
                            margin: 0,
                            onClick: () {}),
                      ),
                      const Space(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                            buttonText: 'Cancel',
                            buttonTextSize: 11,
                            buttonHeight: 40,
                            margin: 0,
                            onClick: () {
                              setState(() {
                                Navigator.pop(context);
                                //  Navigator.of(context).pop();
                                //   Navigator.of(context).pop();
                              });
                            }),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
