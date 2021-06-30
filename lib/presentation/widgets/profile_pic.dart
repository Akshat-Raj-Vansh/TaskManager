//@dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:taskmanager/constants/colors.dart';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    File _storedImage;

    Future<void> chooseAvatar() async {
      final picker = ImagePicker();
      final imageFile = await picker.getImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );
      if (imageFile == null) return;
      setState(() {
        _storedImage = File(imageFile.path);
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage =
          await File(imageFile.path).copy('${appDir.path}/$fileName');
      print(savedImage.path);
    }

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        // Circular Avatar
        Container(
          width: size.width / 2,
          height: size.width / 2,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: kColorWhite,
              width: 5.0,
            ),
            shape: BoxShape.circle,
            color: kColor2,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: _storedImage == null
                  ? AssetImage('assets/images/avatar.png')
                  : FileImage(_storedImage),
            ),
          ),
        ),

        // Edit Icon button
        Positioned(
          bottom: size.width * 0.03,
          right: size.width * 0.03,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: kColorWhite,
                width: 1.0,
              ),
              shape: BoxShape.circle,
              color: kBackgroundColor,
            ),
            child: IconButton(
              onPressed: () {
                chooseAvatar();
              },
              icon: Icon(
                Icons.photo_camera_outlined,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
