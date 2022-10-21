import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram_clone/resources/auth_methods.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:flutter_instagram_clone/widgets/text_field_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //text editing controller definition
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  //dispose
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List imageSelect = await pickImage(ImageSource.gallery);

    setState(() {
      _image = imageSelect;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().SignUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    if (res != 'success') {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //instagram logo
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            SizedBox(
              height: 64,
            ),
            //avatar
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png'),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo_rounded),
                  ),
                )
              ],
            ),

            SizedBox(
              height: 24,
            ),

            //username input
            TextFieldInput(
              textEditingController: _usernameController,
              hintText: 'Enter your Username',
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: 24,
            ),
            //email input
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your Email',
                textInputType: TextInputType.emailAddress),
            SizedBox(
              height: 24,
            ),
            //text field for password
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              isPass: true,
            ),
            //sizedbox
            const SizedBox(
              height: 24,
            ),
            //bio input
            TextFieldInput(
              textEditingController: _bioController,
              hintText: 'Enter your Bio',
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: 24,
            ),

            //button
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: _isLoading
                    ? Center(
                        child: const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Sign Up'),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),

            Flexible(
              child: Container(),
              flex: 2,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Don't have an account?"),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                //use GestureDector not InkWell because this is a line of text
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Text(
                      "Sign up.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
