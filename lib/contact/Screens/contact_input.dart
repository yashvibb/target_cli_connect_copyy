import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Components/choose_options_bottom_sheet.dart';
import '../Components/custom_btn.dart';
import '../Components/my_text_form_field.dart';
import '../Providers/contact_provider.dart';
import 'Components/select_group_btn.dart';
import 'contact_page.dart';

class ContactInput extends StatefulWidget {
  final Map<String, dynamic>? contact;
  final int? index;

  ContactInput({Key? key, this.contact, this.index}) : super(key: key);

  @override
  State<ContactInput> createState() => _ContactInputState();
}

class _ContactInputState extends State<ContactInput> {
  File? imageFile;
  XFile? cameraPhoto;
  DateTime date = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> itemList = [];

  @override
  void initState() {
    debugPrint('contact -> ${widget.contact}');
    if (widget.contact != null) {
      nameController.text = widget.contact!['name'];
      gstNumberController.text = widget.contact!['gstnumber'];
      mobileController.text = widget.contact!['mobile'];
      addressController.text = widget.contact!['address'];
    }
    super.initState();
  }

  void _saveContactToFirebase() async {
    final databaseReference = FirebaseDatabase.instance.reference();
    String? contactKey = databaseReference.child('contacts').push().key;

    Map<String, dynamic> contactData = {
      'name': nameController.text.trim(),
      'mobile': mobileController.text.trim(),
      'address': addressController.text.trim(),
      'gstnumber': gstNumberController.text.trim(),
      'profile': imageFile != null ? imageFile!.path : null,
      'companyDetail': [],
    };

    if (widget.contact != null) {
      contactKey = widget.contact!['key'];
    }

    await databaseReference
        .child('contacts')
        .child(contactKey!)
        .set(contactData);

    // Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffB5C0FF),
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          widget.contact != null ? "Update Contact" : "Add Contact",
          style: TextStyle(
              color: Colors.indigo.shade900, fontWeight: FontWeight.w700),
        )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactPage()));
                      },
                      child: Icon(Icons.close,
                          size: 23, color: Colors.indigo.shade900),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CustomBtn(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Map<String, dynamic> userInfo = {
                              'name': nameController.text.trim(),
                              'mobile': mobileController.text.trim(),
                              'address': addressController.text.trim(),
                              'gstnumber': gstNumberController.text.trim(),
                              'profile':
                                  imageFile != null ? imageFile!.path : null,
                              'companyDetail': [],
                            };
                            try {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user == null) {
                                print("if condithion");
                              }
                              print('firestore');
                              final firestore = FirebaseFirestore.instance;
                              print('firebase with details');
                              if (widget.contact != null) {
                              } else {
                                print("else condithion");
                                await firestore
                                    .collection('contacts')
                                    .add(userInfo);
                              }
                              print('data move contactpage');
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactPage()));

                            } catch (error) {
                              Text("No Data");
                            }
                          }
                        },
                        icon: Icon(
                          Icons.done,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: InkWell(
                    onTap: () async {
                      File? file = await showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        context: context,
                        builder: (context) {
                          return ChooseOptionsBottomSheet();
                        },
                      );
                      if (file != null) {
                        file;
                        if (file != null) {
                          setState(() {
                            imageFile = file;
                          });
                        }
                      }
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: ClipOval(
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.indigo.shade900,
                        ),
                        child: ClipOval(
                          child: imageFile != null
                              ? Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Color(0xffB5C0FF),
                                  )),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (newDate == null) return;
                      setState(() {
                        date = newDate;
                      });
                    },
                    child: Text(
                      'Date: ${date.year} / ${date.day} / ${date.month}',
                      style: TextStyle(
                          fontSize: 15, color: Colors.indigo.shade900),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: nameController,
                  label: "Company Name (કંપની નામ)",
                  validator: (name) {
                    if (name == null || name.trim().isEmpty) {
                      return "Please enter name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: addressController,
                  label: "Address (સરનામું)",
                  validator: (address) {
                    if (address == null || address.trim().isEmpty) {
                      return "Please enter address";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: gstNumberController,
                  label: "GST Number (જીએસટી નંબર)",
                  maxLength: 13,
                  validator: (gstnumber) {
                    if (gstnumber == null || gstnumber.trim().isEmpty) {
                      return "Please enter GST number";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: mobileController,
                  label: "Mobile Number (મોબાઈલ નંબર)",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (phone) {
                    if (phone == null || phone.trim().isEmpty) {
                      return "Please enter phone number";
                    } else {
                      if (phone.trim().length != 10) {
                        return "Invalid number";
                      } else {
                        return null;
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
