import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _profileImage;
  bool _isPasswordVisible = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('profile',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
        actions: [
          TextButton(onPressed: (){}, child: Icon(Icons.settings,color: Colors.black,))
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,backgroundColor: Colors.black,

                      ),
                    Positioned(top: 5,left: 5,
                      child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(File(_profileImage!.path))
                          : NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi55zwMGzU8h8cTwIMi5rosGGdeCDT0tMBUA&s") as ImageProvider,
                                        ),
                    ),
              ]
                ),

                  ),
                SizedBox(height: 20),
                Text(
                  _nameController.text.isEmpty ? 'Name' : _nameController.text,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _designationController.text.isEmpty ? 'Designation' : _designationController.text,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                   labelText: "Name"
                      ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _designationController,
                  decoration: InputDecoration(
                    hintText: "Designation",
                    labelText: "Designation",

                      ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    labelText: 'Password'

                     ),

                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confime Password';
                    }
                    return null;
                  },
                ), SizedBox(height: 20),
                TextFormField(

                  controller: _confirmPasswordController,
                  decoration: InputDecoration(

                      hintText: "Confirm password",
                      labelText: "Confirm password",
                   suffixIcon: IconButton(icon: Icon(
                     _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                   ),onPressed: (){setState((

                       ) {
                     _isPasswordVisible = !_isPasswordVisible;
                   });},
                   )
                      ),

                  obscureText:!_isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please confirm password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Container(height: 50,width: 350,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(21)),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password has been updated')),
                        );
                      }
                    },
                    child: Text('save',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileUpdateScreen()),
                    );
                  },
                  child: Text('Logout',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
