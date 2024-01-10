import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/custom_icon_btn.dart';
import '../Constants/color_const.dart';
import '../HelperFunctions/launcher_functions.dart';
import '../HelperFunctions/my_text_style.dart';
import '../Providers/contact_provider.dart';
import 'Components/confirmation_popup.dart';
import 'Components/user_details.dart';
import 'contact_input.dart';
import 'no_contact_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController _searchController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> contacts = [];

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    try {
      var snapshot = await firestore.collection('contacts').get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          contacts = snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        });
      }
    } catch (e) {
      print("Error fetching contacts: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    print("Number of contacts: ${contacts.length}");
    List<Map<String, dynamic>> filteredContacts = contacts
        .where((contact) =>
    contact['name']
        .toLowerCase()
        .contains(_searchController.text.toLowerCase()) ||
        contact['mobile']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 15),
            child: Icon(Icons.more_vert, color: Colors.indigo.shade900),
          ),
        ],
        backgroundColor: Color(0xffB5C0FF),
        title: Text("Contact List ",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.indigo.shade900)),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ContactInput(),
            ),
          );
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 13,
        ),
        child: filteredContacts.isEmpty
            ? NoContactPage()
            : ListView.builder(
          padding: const EdgeInsets.only(bottom: 55),
          itemCount: filteredContacts.length,
          itemBuilder: (context, index) {
            final contact = filteredContacts[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => UserDetails(
                        contact: contact,
                        index: index,
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
                                      style: MyTextStyle.bold
                                          .copyWith(
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
                                      style: MyTextStyle.semiBold
                                          .copyWith(
                                        color: Colors.indigo.shade900,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // Text(
                                  //   contact['mobile'],
                                  //   style: MyTextStyle.regular.copyWith(
                                  //     color: Color(0xffB5C0FF),
                                  //     fontSize: 13.5,
                                  //   ),
                                  // ),
                                ],
                              ),
                              const Spacer(),
                              CustomIconBtn(
                                iconColor: Colors.purple,
                                background:
                                Colors.purple.withOpacity(0.1),
                                onTap: () async {
                                  smsLauncher(contact['mobile']);
                                },
                                icon: Icon(Icons.message,
                                    size: 17, color: Colors.pink),
                              ),
                              const SizedBox(width: 15),
                              CustomIconBtn(
                                iconColor: Colors.orange,
                                background:
                                Colors.orange.withOpacity(0.1),
                                onTap: () {
                                  callerLauncher(contact['mobile']);
                                },
                                icon: Icon(Icons.call,
                                    size: 19, color: Colors.orange),
                              ),
                              const SizedBox(width: 5),
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
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              ContactInput(
                                                contact: contact,
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
                                                contact: contact),
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
    );
  }
}

class SearchContactDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> contactList;

  SearchContactDelegate(this.contactList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, 'result');
      },
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement suggestions based on the search query
    List<Map<String, dynamic>> filteredContacts = contactList
        .where((contact) =>
    contact['name'].toLowerCase().contains(query.toLowerCase()) ||
        contact['mobile'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final Map<String, dynamic> contact = filteredContacts.elementAt(index);
        return ListTile(
          title: Text(contact['name']),
          subtitle: Text(contact['mobile']),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetails(
                  index: index,
                  contact: {},
                ),
              ),
            );
          },
        );
      },
    );
  }
}
