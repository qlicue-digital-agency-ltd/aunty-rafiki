import 'package:aunty_rafiki/models/user.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final Function onTap;
  final User user;

  const ProfileAvatar({Key key, this.onTap, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/icons/female.png')),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                      height: 30,
                      width: 30,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
          Text(user.displayName)
        ],
      ),
    );
  }
}
