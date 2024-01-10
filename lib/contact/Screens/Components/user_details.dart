import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:screenshot/screenshot.dart';
import '../../Components/custom_icon_btn.dart';
import '../../Constants/color_const.dart';
import '../../HelperFunctions/launcher_functions.dart';
import '../../HelperFunctions/my_text_style.dart';
import 'package:path_provider/path_provider.dart';
import '../second_screens/contact_input_2.dart';
import '../second_screens/user_details_2.dart';
import 'confirmation_popup.dart';

class UserDetails extends StatefulWidget {
  final Map<String, dynamic> contact;
  final int? index;
  final Stream<DocumentSnapshot<Map<String, dynamic>>>? contactStream;

  const UserDetails({
    Key? key,
    this.index,
    required this.contact, this.contactStream,
  }) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late ScreenshotController screenshotController;
  DateTime date = DateTime.now();
  late CollectionReference userContacts;
  List<Map<String, dynamic>> contactList2 = [];

  @override
  void initState() {
    super.initState();
    screenshotController = ScreenshotController();
    userContacts = FirebaseFirestore.instance.collection('userContacts');
  }

  Future<void> _takeScreenshot() async {
    Uint8List? imageBytes = await screenshotController.capture();
    if (imageBytes != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Image.memory(imageBytes),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
              ElevatedButton(
                onPressed: () async {
                  String path = await _saveImage(imageBytes);
                },
                child: Text('Share'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<String> _saveImage(Uint8List imageBytes) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/screenshot.png';
    File(path).writeAsBytesSync(imageBytes);
    return path;
  }

  Widget keyValue({
    required String key,
    required String value,
    void Function()? onTap,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "\u2739 ",
                  style: MyTextStyle.bold.copyWith(
                    color: Colors.indigo.shade900,
                  ),
                ),
                TextSpan(
                  text: key,
                  style: MyTextStyle.medium.copyWith(
                    color: Color(0xffB5C0FF),
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: MyTextStyle.bold.copyWith(
                    color: Colors.indigo.shade900,
                    fontSize: 15.5,
                  ),
                ),
                if (onTap != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: onTap,
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: Icon(
                          Icons.copy,
                          size: 20,
                          color: ColorConst.grey400,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffB5C0FF),
        leading: IconButton(
            color: Colors.indigo.shade900,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
            )),
        title: Text(
          "${widget.contact["name"]}'s details",
          style: TextStyle(color: Colors.indigo.shade900),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          Map<String, dynamic>? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Contact_Input_2(),
            ),
          );
          if (result != null) {
            print("Received contact details: $result");
          }
        },
        borderRadius: BorderRadius.circular(60),
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffB5C0FF),
          ),
          child: Icon(
            Icons.add_call,
            color: Colors.indigo.shade900,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: widget.contact["profile"] != null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: ColorConst.appPrimary,
                                    width: 0.75,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    widget.contact["profile"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Color(0xffB5C0FF),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.indigo.shade900,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconBtn(
                            iconColor: Colors.orange,
                            background: Colors.orange.withOpacity(0.2),
                            size: 35,
                            onTap: () {
                              callerLauncher(widget.contact['mobile']);
                            },
                            icon: Icon(
                              Icons.call,
                              size: 19,
                              color: Colors.yellow.shade900,
                            ),
                          ),
                          const SizedBox(width: 10),
                          CustomIconBtn(
                            size: 35,
                            onTap: () async {
                              whatsappLaunch(widget.contact['mobile']);
                            },
                            icon: Icon(
                              Icons.maps_ugc,
                              size: 17,
                              color: Colors.green.shade900,
                            ),
                            background: Colors.teal.withOpacity(0.2),
                            colorFilter: const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.difference,
                            ),
                          ),
                          const SizedBox(width: 10),
                          CustomIconBtn(
                            size: 35,
                            iconColor: Colors.purple,
                            background: Colors.purple.withOpacity(0.2),
                            onTap: () {
                              smsLauncher(widget.contact['mobile']);
                            },
                            icon: Icon(
                              Icons.sms,
                              size: 17,
                              color: Colors.pink.shade900,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
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
                    const SizedBox(height: 10),
                    keyValue(
                      key: "Name (નામ)",
                      value: "${widget.contact['name']}",
                    ),
                    const SizedBox(height: 10),
                    keyValue(
                      key: "Address (સરનામું)",
                      value: "${widget.contact['address']}",
                    ),
                    const SizedBox(height: 10),
                    keyValue(
                      key: "GST Number (જીએસટી નંબર)",
                      value: "${widget.contact['gstnumber']}",
                    ),
                    SizedBox(height: 10),
                    keyValue(
                      key: "Mobile (મોબાઈલ નંબર)",
                      value: "${widget.contact['mobile']}",
                      onTap: () async {
                        await Clipboard.setData(
                            ClipboardData(text: widget.contact['mobile']));
                        Fluttertoast.showToast(msg: "Copied");
                      },
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 1.5,
                      color: Colors.indigo.shade900,
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 170,
                      width: 450,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 55),
                        itemCount: contactList2.length,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> contact =
                          contactList2.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => User_Details_2(
                                      contact: contact,
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(5.0),
                              splashColor: ColorConst.appPrimary.withOpacity(0.1),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: ColorConst.grey400,
                                    width: 0.45,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: contact["profile"] != null
                                                  ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.indigo.shade900,
                                                    width: 0.75,
                                                  ),
                                                ),
                                                child: ClipOval(
                                                  child: Image.file(
                                                    File(contact["profile"]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                                  : Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.indigo.shade900,
                                                  border: Border.all(
                                                    width: 0.35,
                                                    color: Color(0xffB5C0FF),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    contact['name']
                                                        .substring(0, 1)
                                                        .toString()
                                                        .toUpperCase(),
                                                    style:
                                                    MyTextStyle.bold.copyWith(
                                                      color: Color(0xffB5C0FF),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    contact['name'],
                                                    style:
                                                    MyTextStyle.semiBold.copyWith(
                                                      color: Colors.indigo.shade900,
                                                      fontSize: 16,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: PopupMenuButton(
                                        offset: const Offset(6, 30),
                                        elevation: 3.0,
                                        tooltip: "Update-Delete",
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Icon(
                                          Icons.more_vert,
                                          size: 25,
                                          color: Colors.indigo.shade900,
                                        ),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              onTap: () {
                                                Future.delayed(
                                                  Duration.zero,
                                                      () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Contact_Input_2(
                                                              contact2: contact,
                                                              index: index,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              value: "Update",
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Update",
                                                    style: MyTextStyle.medium.copyWith(
                                                        fontSize: 15,
                                                        color: Colors.indigo.shade900),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Icon(
                                                    Icons.mode_edit,
                                                    size: 17,
                                                    color: Colors.indigo.shade900,
                                                  )
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                Future.delayed(
                                                  const Duration(seconds: 0),
                                                      () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          ConfirmationPopup(
                                                            contact: contact,),
                                                    );
                                                  },
                                                );
                                              },
                                              value: "Delete",
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Delete",
                                                    style: MyTextStyle.medium.copyWith(
                                                      fontSize: 15,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 13),
                                                  const Icon(
                                                    Icons.delete,
                                                    size: 17,
                                                    color: Colors.red,
                                                  )
                                                ],
                                              ),
                                            )
                                          ];
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Container(
                    //   height: 170,
                    //   width: 450,
                    //   child: StreamBuilder<QuerySnapshot>(
                    //     stream: userContacts.snapshots(),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasData && snapshot.data != null) {
                    //         contactList2 = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
                    //         return ListView.builder(
                    //           padding: const EdgeInsets.only(bottom: 55),
                    //           itemCount: contactList2.length,
                    //           itemBuilder: (context, index) {
                    //             final Map<String, dynamic> contact2 = contactList2.elementAt(index);
                    //             return Padding(
                    //               padding: const EdgeInsets.only(bottom: 10),
                    //               child: InkWell(
                    //                 onTap: () {
                    //                   Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                       builder: (context) => User_Details_2(
                    //                         contact: {},
                    //                       ),
                    //                     ),
                    //                   );
                    //                 },
                    //                 borderRadius: BorderRadius.circular(5.0),
                    //                 splashColor:
                    //                 ColorConst.appPrimary.withOpacity(0.1),
                    //                 child: Container(
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(5.0),
                    //                     border: Border.all(
                    //                       color: ColorConst.grey400,
                    //                       width: 0.45,
                    //                     ),
                    //                   ),
                    //                   child: Row(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       Flexible(
                    //                         child: Padding(
                    //                           padding: const EdgeInsets.only(
                    //                             left: 10,
                    //                             top: 8,
                    //                             bottom: 8,
                    //                           ),
                    //                           child: Row(
                    //                             children: [
                    //                               SizedBox(
                    //                                 width: 50,
                    //                                 height: 50,
                    //                                 child: contact2["profile"] != null
                    //                                     ? Container(
                    //                                   decoration: BoxDecoration(
                    //                                     borderRadius:
                    //                                     BorderRadius
                    //                                         .circular(50),
                    //                                     border: Border.all(
                    //                                       color: Colors
                    //                                           .indigo.shade900,
                    //                                       width: 0.75,
                    //                                     ),
                    //                                   ),
                    //                                   child: ClipOval(
                    //                                     child: Image.file(
                    //                                       File(contact2[
                    //                                       "profile"]),
                    //                                       fit: BoxFit.cover,
                    //                                     ),
                    //                                   ),
                    //                                 )
                    //                                     : Container(
                    //                                   decoration: BoxDecoration(
                    //                                     shape: BoxShape.circle,
                    //                                     color: Colors
                    //                                         .indigo.shade900,
                    //                                     border: Border.all(
                    //                                       width: 0.35,
                    //                                       color:
                    //                                       Color(0xffB5C0FF),
                    //                                     ),
                    //                                   ),
                    //                                   child: Center(
                    //                                     child: Text(
                    //                                       contact2['name']
                    //                                           .substring(0, 1)
                    //                                           .toString()
                    //                                           .toUpperCase(),
                    //                                       style: MyTextStyle
                    //                                           .bold
                    //                                           .copyWith(
                    //                                         color: Color(
                    //                                             0xffB5C0FF),
                    //                                         fontSize: 20,
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               const SizedBox(width: 15),
                    //                               Column(
                    //                                 mainAxisSize: MainAxisSize.min,
                    //                                 crossAxisAlignment:
                    //                                 CrossAxisAlignment.start,
                    //                                 children: [
                    //                                   SizedBox(
                    //                                     width: 100,
                    //                                     child: Text(
                    //                                       contact2['name'],
                    //                                       style: MyTextStyle.semiBold
                    //                                           .copyWith(
                    //                                         color: Colors
                    //                                             .indigo.shade900,
                    //                                         fontSize: 16,
                    //                                       ),
                    //                                       overflow:
                    //                                       TextOverflow.ellipsis,
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               Spacer(),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(8.0),
                    //                         child: PopupMenuButton(
                    //                           offset: const Offset(6, 30),
                    //                           elevation: 3.0,
                    //                           tooltip: "Update-Delete",
                    //                           shape: RoundedRectangleBorder(
                    //                             borderRadius:
                    //                             BorderRadius.circular(5.0),
                    //                           ),
                    //                           child: Icon(
                    //                             Icons.more_vert,
                    //                             size: 25,
                    //                             color: Colors.indigo.shade900,
                    //                           ),
                    //                           itemBuilder: (context) {
                    //                             return [
                    //                               PopupMenuItem(
                    //                                 onTap: () {
                    //                                   Future.delayed(
                    //                                     Duration.zero,
                    //                                         () async {
                    //                                       await Navigator.push(
                    //                                         context,
                    //                                         MaterialPageRoute(
                    //                                           builder: (context) =>
                    //                                               Contact_Input_2(
                    //                                                 contact2: contact2,
                    //                                               ),
                    //                                         ),
                    //                                       );
                    //                                     },
                    //                                   );
                    //                                 },
                    //                                 value: "Update",
                    //                                 child: Row(
                    //                                   children: [
                    //                                     Text(
                    //                                       "Update",
                    //                                       style: MyTextStyle.medium
                    //                                           .copyWith(
                    //                                           fontSize: 15,
                    //                                           color: Colors.indigo
                    //                                               .shade900),
                    //                                     ),
                    //                                     const SizedBox(width: 10),
                    //                                     Icon(
                    //                                       Icons.mode_edit,
                    //                                       size: 17,
                    //                                       color:
                    //                                       Colors.indigo.shade900,
                    //                                     )
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                               PopupMenuItem(
                    //                                 onTap: () {
                    //                                   Future.delayed(
                    //                                     const Duration(seconds: 0),
                    //                                         () {
                    //                                       showDialog(
                    //                                         context: context,
                    //                                         builder: (context) =>
                    //                                             ConfirmationPopup(
                    //                                               contact: contact2,
                    //                                             ),
                    //                                       );
                    //                                     },
                    //                                   );
                    //                                 },
                    //                                 value: "Delete",
                    //                                 child: Row(
                    //                                   children: [
                    //                                     Text(
                    //                                       "Delete",
                    //                                       style: MyTextStyle.medium
                    //                                           .copyWith(
                    //                                         fontSize: 15,
                    //                                         color: Colors.red,
                    //                                       ),
                    //                                     ),
                    //                                     const SizedBox(width: 13),
                    //                                     const Icon(
                    //                                       Icons.delete,
                    //                                       size: 17,
                    //                                       color: Colors.red,
                    //                                     )
                    //                                   ],
                    //                                 ),
                    //                               )
                    //                             ];
                    //                           },
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         );
                    //       } else {
                    //         return CircularProgressIndicator();
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              )
    )
    );
  }
}