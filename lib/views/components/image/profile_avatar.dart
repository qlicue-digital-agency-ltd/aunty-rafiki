import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
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
                  backgroundImage: AssetImage('assets/images/b.jpg')),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    print('object');
                  },
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
          Text('Robin')
        ],
      ),
    );
  }
}
