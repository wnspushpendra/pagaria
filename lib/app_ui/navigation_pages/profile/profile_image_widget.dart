import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';


class ProfileImageWidget extends StatefulWidget {
   String networkUrl;
  final ValueChanged<XFile> onFileChange;
   ProfileImageWidget({required this.networkUrl,required this.onFileChange,super.key});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  File? file;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
           picCaptureImageDialog();
           }
             ,
          child: ClipRRect(
            borderRadius:
            const BorderRadius.all(Radius.circular(50)),
            child:
            file == null && widget.networkUrl.isEmpty
                ? Image.asset(
              logo,
              height: 100.0,
              width: 100.0,
            ) : widget.networkUrl.isNotEmpty? CachedNetworkImage(
              imageUrl: widget.networkUrl,
              fit: BoxFit.fill,
              height: 100.0,
              width: 100.0,
              placeholder: (context,url) => const CircularProgressIndicator(),
            )
                : Image.file(
              file!,
              fit: BoxFit.fill,
              height: 100.0,
              width: 100.0,
            ),
          ),
        ),
      ],
    );
  }

 picCaptureImageDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const BodyText(text: 'Take a picture'),
              onTap: () {
                picCameraImage().then((value) {
                setState(() {
                  file = File(value!.path);
                  widget.onFileChange(value);
                  Navigator.of(context).pop();
                  // context.read<UserProfileBloc>().add(UpdateProfileImageEvent(profileImage: file));
                });
              });
            },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const BodyText(text: 'Choose from gallery'),
              onTap: () {
                pickSingleFile().then((value) {
                  setState(() {
                    file = File(value.path);
                    widget.onFileChange(value);
                    Navigator.of(context).pop();
                    // context.read<UserProfileBloc>().add(UpdateProfileImageEvent(profileImage: file));
                  });
                });               },
            ),
          ],
        );
      },
    ).then((pickedFile) {
      if (pickedFile != null) {
        print('Picked file path: ${pickedFile.path}');
      }
    });
  }


}
