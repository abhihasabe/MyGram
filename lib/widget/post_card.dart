import 'package:flutter/material.dart';
import 'package:mygram_app/models/post_model.dart';
import 'package:mygram_app/screens/profile_screen.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key key, this.choice, this.onTap, @required this.item, this.selected: false}) : super(key: key);
  final AlertWithUsers choice;
  final VoidCallback onTap;
  final AlertWithUsers item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Card(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 15,
                      backgroundImage: choice?.user?.photoURL!=null?NetworkImage(choice?.user?.photoURL):NetworkImage("https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=6&m=1223671392&s=612x612&w=0&h=NGxdexflb9EyQchqjQP0m6wYucJBYLfu46KCLNMHZYM=")
                  ),
                  SizedBox(width: 8),
                  InkWell(onTap:() {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Profile(choice?.user)), (Route<dynamic> route) => true);
                  },child: choice?.user!=null?Text(choice?.user?.firstName +" "+ choice?.user?.middleName+ " "+choice?.user?.lastName,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)):Container())
                ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.network(
                    choice?.alert?.photoURL,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8, top: 12),
                  child: Text(choice?.alert?.title,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                      maxLines: 1),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8, top: 4),
                  child: Text(choice?.alert.description,
                      style: TextStyle(fontSize: 12), textAlign: TextAlign.left, maxLines: 5),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ],
        ));
  }
}