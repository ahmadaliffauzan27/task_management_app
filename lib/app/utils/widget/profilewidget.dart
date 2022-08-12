import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/app/utils/style/Appcolors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: !context.isPhone ? Row(
        children: [
          const Expanded(
            flex: 1,
            child: ClipRRect(
                      child: CircleAvatar(
                        backgroundColor: Colors.amber, 
                        radius: 150, 
                        foregroundImage: NetworkImage('https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2022/06/26/4162943265.jpg'),
                      ),
                      ),
          ),
            //SizedBox(width: 20,),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                 Text(
                  'Monkey D. Luffy', 
                style: TextStyle(
                  color: AppColors.primaryText, 
                  fontSize: 40,
                  ),
                  ),
                   Text(
              'Luffy-gomugomu@gmail.com', 
            style: TextStyle(
              color: AppColors.primaryText, 
              fontSize: 16,
              ),
              ),
              ],
            ),

          ),
        ],
      ):Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
             SizedBox(height: 20),
            ClipRRect(
                      child: CircleAvatar(
                        backgroundColor: Colors.amber, 
                        radius: 100, 
                        foregroundImage: NetworkImage('https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2022/06/26/4162943265.jpg'),
                      ),
                      ),
              SizedBox(height: 20),
            Text(
             'Ahmad Alif Fauzan', 
                style: TextStyle(
             color: AppColors.primaryText, 
             fontSize: 25,
             ),
             ),
              Text(
              'ahmadaliffauzan@gmail.com', 
            style: TextStyle(
              color: AppColors.primaryText, 
              fontSize: 16,
              ),
              ),
          ],
        ),
      ),
      );
  }
}

