// flutter
import 'package:flutter/material.dart';
import 'package:botob/view/component/image/circle_image.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    Key? key,
    required this.length,
    required this.userImageUrl,
  }) : super(key: key);

  final double length;
  final String userImageUrl;

  @override
  Widget build(BuildContext context) {
    return userImageUrl.isEmpty
        ? Container(
            alignment: Alignment.center,
            width: length,
            height: length,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0),
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.person,
              size: length * .8,
              color: Colors.black,
            ),
          )
        : CircleImage(
            length: length,
            image: NetworkImage(userImageUrl),
          );
  }
}
