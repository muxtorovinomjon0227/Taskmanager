import 'package:flutter/material.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       body: Center(
         child: Text("Comment Page",style: TextStyle(
           color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20
         ),),
       ),
    );
  }
}
