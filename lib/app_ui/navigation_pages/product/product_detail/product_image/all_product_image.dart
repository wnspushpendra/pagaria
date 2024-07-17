import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';



class ViewMetromonialProfileImages extends StatefulWidget {
  const ViewMetromonialProfileImages({Key? key}) : super(key: key);

  @override
  State<ViewMetromonialProfileImages> createState() => _ViewMetromonialProfileImagesState();
}

class _ViewMetromonialProfileImagesState extends State<ViewMetromonialProfileImages> {
  bool fullImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(
            context,
            'Product Images',
            () => Navigator.pop(context)),
        body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          shrinkWrap: true,
          children: List.generate(
            20,
            (index) {
              return InkWell(
                onTap:()=> showDialog(
                    context: context,
                    builder: (_) => imageDialog(networkImage, context)),
                child:  CachedNetworkImage(
                  imageUrl: networkImage,
                  fit: BoxFit.fill,
                ),
              );
            },
          ),
        ));
  }

  Widget imageDialog( path, context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /*  Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),*/
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.98,
            height: MediaQuery.of(context).size.height * 0.50,
            child: CachedNetworkImage(
              imageUrl: path,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

}

