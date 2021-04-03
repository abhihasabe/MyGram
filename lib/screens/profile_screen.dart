import 'package:flutter/material.dart';
import 'package:mygram_app/models/post_model.dart';

class Profile extends StatefulWidget {
  User user;

  Profile(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserProfile(user);
  }
}

class _UserProfile extends State {
  User user;

  _UserProfile(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("User Profile"),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Row(
                  children: [
                    Text("Name: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    Text("${user.firstName} ${user.middleName} ${user.lastName}"),
                  ],
                ),
          ),
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Row(
                  children: [
                    Text("Email: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    Text("${user.email}"),
                  ],
                ),
          ),
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Row(
                  children: [
                    Text("Phone Number: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    Text("${user.phoneNumber}"),
                  ],
                ),
          ),
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Row(
                  children: [
                    Text("Gender: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    Text("${user.gender}"),
                  ],
                ),
          ),
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Row(
                  children: [
                    Text("Village: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    Text("${user.village}"),
                  ],
                ),
          ),
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Row(
                  children: [
                    Text("Profession: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    Text("${user.profession}"),
                  ],
                ),
          ),
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Row(
                  children: [
                    Text("Address: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                    Text("${user.addressLine1}"),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}
