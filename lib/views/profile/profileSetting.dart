import 'package:e_commerce/views/profile/viewmodels/image_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {

  bool? isPicked;
  var imageFile;
  final _imageViewModel = ImageViewModel();
  final TextEditingController firstNameController = TextEditingController(text: 'John');
  final TextEditingController lastNameController = TextEditingController(text: 'Doe');
  final TextEditingController emailController = TextEditingController(text: 'johndoe@example.com');
  final TextEditingController genderController = TextEditingController(text: 'Male');
  final TextEditingController phoneController = TextEditingController(text: '12345678');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Setting',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Center(
          child: Column(
            children: [
              _buildProfileAvatarWithCamera(),
              const SizedBox(height: 60),
              _buildTwoTextFieldsRow(),
              const SizedBox(height: 40),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  label: Text('Email'),
                ),
              ),
              const SizedBox(height: 40),
              _buildReversedTwoTextFieldsRow(),
              const SizedBox(height: 100),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(79, 152, 146, 1),
                  minimumSize: const Size(203, 48),
                ),
                onPressed: (){_updateProfileInfo();},
                child: const Text('Save Change', style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'ProductSans',
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatarWithCamera() {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 200,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Choose Profile Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text(
                      'Take a Photo',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      _getImageFromSource(source: 'camera');
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_size_select_actual_outlined),
                    title: const Text(
                      'Choose from Gallery',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      _getImageFromSource(source: 'gallery');
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                ],
              ),
            );
          },
        );
      },

      child: Stack(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://th.bing.com/th/id/OIP.6kHMp3QH7uAFyzTbauvJLAHaKe?rs=1&pid=ImgDetMain'),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTwoTextFieldsRow() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: firstNameController,
            decoration: const InputDecoration(
              label: Text('First Name'),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: lastNameController,
            decoration: const InputDecoration(
              label: Text('Last Name'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReversedTwoTextFieldsRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: genderController,
            decoration: const InputDecoration(
              label: Text('Gender'),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              label: Text('Phone'),
              prefixText: '+855 '
            ),
          ),
        ),
      ],
    );
  }

  _getImageFromSource({source}) async {

    XFile? pickedFile = await ImagePicker().pickImage(
      source: source == 'gallery' ? ImageSource.gallery : ImageSource.camera,
    );
    if(pickedFile != null){
      // uploading image to server
      _imageViewModel.uploadingImage(pickedFile.path);
      // setState(() {
      //   isPicked = true;
      //   imageFile = File(pickedFile.path);
      // });
    }
  }

  void _updateProfileInfo() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String email = emailController.text;
    final String gender = genderController.text;
    final String phone = phoneController.text;

    // Implement your logic to save/update the profile info
  }

}

