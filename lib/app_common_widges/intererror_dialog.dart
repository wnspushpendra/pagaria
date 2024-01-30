import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';

class NetworkErrorDialog extends StatefulWidget {

  const NetworkErrorDialog({Key? key, this.onPressed}) : super(key: key);
  final Function()? onPressed;

  @override
  State<NetworkErrorDialog> createState() => _NetworkErrorDialogState();
}

class _NetworkErrorDialogState extends State<NetworkErrorDialog> {

  @override
  void initState() {
    super.initState();
    initDialog();
  }

  initDialog(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return internetErrorDialog();
        },
        barrierColor: Colors.white.withOpacity(0.8), // Set the barrier color to white
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
  AlertDialog internetErrorDialog(){
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Set radius to 0 for no border radius
      ),
      content: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: bodyLightBlack,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 200,
                child: Image.asset(networkErrorImage,height: 100,)
            ),
            const SizedBox(height: 32),
            const BodyText(text :
            "Whoops!",color: bodyWhite,fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            const BodyText(text : "No internet connection found.",
              fontSize: 16, color: bodyWhite,fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            const BodyText(text :
            "Check your connection and try again.",fontSize: 14,color: bodyWhite,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: (){},
              child: const Text("Try Again"),
            )
          ],
        ),
      ),
    );
  }
}