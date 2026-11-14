import 'package:flutter/material.dart';
import '../helper/app_utilities/app_images.dart';
import '../helper/app_utilities/size_reziser.dart';
import '../helper/dxWidget/dx_input_fields.dart';
import '../helper/dxWidget/dx_text.dart';

class OverLappedLoginCard extends StatelessWidget {
   OverLappedLoginCard({super.key});

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 120, left: 10, right: 10),
          child: Opacity(
            opacity: 0.5,
            child:
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              height: SizeConfig.screenHeight * 0.7 + 16,
              width: SizeConfig.screenWidth * 0.92 -20,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 120, left: 5, right: 5),
          child: Opacity(
            opacity: 0.7,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              height: SizeConfig.screenHeight * 0.7 + 8,
              width: SizeConfig.screenWidth * 0.92 - 10,

            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 120),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            height: SizeConfig.screenHeight * 0.7,
            width: SizeConfig.screenWidth * 0.92,
            child: Column(
              children: [
                Image(image: AssetImage(AppImages.plate)),
                DxText("Welcome", mSize: 36,mBold: true,textColor: Colors.red,),
                DxText("We Love to see you again", textColor: Colors.grey,mSize: 16,),
                SizedBox(height: 20,),
                TextFieldWidget(hintText: 'Enter your phone number', prefixIcon: Icons.person, textController: phoneController,),
                SizedBox(height: 10,),
                TextFieldWidget(hintText: 'Enter your password', prefixIcon: Icons.password, textController: phoneController,),
                SizedBox(height: 10,),
                Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 40.0),
                    width: SizeConfig.screenWidth,
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child:
                      Text("Sign In", style: TextStyle(color: Colors.white)),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.red
                 ),
                    )),

                SizedBox(height: 5,),
                DxText("Don't have an account?", mSize: 16,),

                TextButton(onPressed: (){}, child: Text("Sign Up", style: TextStyle(color: Colors.red,fontSize: 14),))



              ],
            ),

          ),
        )
      ],
    );
  }
}
