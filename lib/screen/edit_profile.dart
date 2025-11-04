import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

enum GenderCharacter { Male, Female }

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GenderCharacter? _character = GenderCharacter.Male;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  DateTime? _selectedDate;

  String? _selectedCountry;
  final List<String> _country = ["Indonesia", "US", "UK"];

  File? _imageFile;

  Future<void> _imagePicker() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      initialDate: _selectedDate ?? DateTime.now(),
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _firstName.dispose();
    _lastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Set Up Profile", style: TextStyle(fontSize: 24)),
                SizedBox(height: 12),
        
                InkWell(
                  onTap: _imagePicker,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: _imageFile == null
                        ? AssetImage("assets/images/150.jpeg")
                        : FileImage(_imageFile!) as ImageProvider,
                    child: _imageFile == null
                        ? const Icon(
                            Icons.camera_alt,
                            color: Colors.white70,
                            size: 30,
                          )
                        : null,
                  ),
                ),
                SizedBox(height: 12),
        
                TextField(
                  controller: _firstName,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
        
                TextField(
                  controller: _lastName,
                  decoration: InputDecoration(
                    labelText: "Surname",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                _gender(),
                SizedBox(height: 12),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCountry,
                  hint: Text("Select your country"),
                  items: _country.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _selectedCountry = newValue;
                  },
                  decoration: InputDecoration(
                    labelText: "Country",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
        
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    fixedSize: Size(double.maxFinite, 40),
                  ),
                  onPressed: () {},
                  child: Text("Set Up", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _gender() {
    return Column(
      children: [
        Text("Gender"),
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text("Male"),
                leading: Radio<GenderCharacter>(
                  value: GenderCharacter.Male,
                  groupValue: _character,
                  onChanged: (GenderCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    _character = GenderCharacter.Male;
                  });
                },
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text("Female"),
                leading: Radio<GenderCharacter>(
                  value: GenderCharacter.Female,
                  groupValue: _character,
                  onChanged: (GenderCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),

                onTap: () {
                  setState(() {
                    _character = GenderCharacter.Female;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
