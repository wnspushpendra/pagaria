import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';


class ProfileImageWidget extends StatefulWidget {
  final String networkUrl;
  final ValueChanged<XFile>? onFileChange;
  final bool? showIcon;
   const ProfileImageWidget({required this.networkUrl, this.onFileChange, this.showIcon = true,super.key});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  File? file;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          InkWell(
            onTap: ()=> picCaptureImageDialog()
               ,
            child: ClipRRect(
              borderRadius:
              const BorderRadius.all(Radius.circular(50)),
              child:
                  file != null ?
                  Image.file(
                    file!,
                    fit: BoxFit.fill,
                    height: 100.0,
                    width: 100.0,
                  ) :
              widget.networkUrl.isNotEmpty? CachedNetworkImage(
                imageUrl: widget.networkUrl,
                fit: BoxFit.fill,
                height: 100.0,
                width: 100.0,
                placeholder: (context,url) => Image.asset(defaultImage,),
                errorWidget: (context, url, error) => Image.asset(defaultImage), // Replace errorImage with the path to your error image
              ) : Image.asset(
                defaultImage,
                height: 100.0,
                width: 100.0,
              )
            ),
          ),
         widget.showIcon == true ? Positioned(
            bottom: -10,
              right: -10,
              child: IconButton(onPressed: ()=>picCaptureImageDialog(), icon: const Icon(Icons.edit,color: primaryColor,size: 32,))) : Container()
        ],
      ),
    );
  }

 picCaptureImageDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 180,
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      picCameraImage().then((value) {
                        setState(() {
                          file = File(value!.path);
                          widget.onFileChange!(value);
                          Navigator.of(context).pop();
                        });
                      });
                    },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(cameraImage,width: 60,),
                          ),
                          const BodyText(text: 'Camera')
                        ],
                      ))),
              Expanded(
                flex: 1,
                  child: GestureDetector(
                      onTap: (){
                        pickSingleFile().then((value) {
                          if(value != null){
                            setState(() {
                              widget.onFileChange!(value);
                              file = File(value.path);
                            });
                          }
                          Navigator.of(context).pop();

                        });
                      },
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(galleryImage,width: 60,)),
                          const BodyText(text: 'Gallery')

                        ],
                      ))),
            ],
          ),
        );
      },
    ).then((pickedFile) {
      if (pickedFile != null) {
        print('Picked file path: ${pickedFile.path}');
      }
    });
  }


}
