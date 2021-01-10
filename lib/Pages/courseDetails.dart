import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CourseDetails extends StatefulWidget {
  var _course ;
  CourseDetails(this._course) ;

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Course Details"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [

              Card(
                margin: const EdgeInsets.all(10.0), 
                elevation: 10.0,
                child: Container(
                  height: 100,
                  child: Center(
                    child: Text(
                      "Course Name : ${widget._course.name}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),

              Card(
                margin: const EdgeInsets.all(10.0),
                elevation: 10.0 ,
                child: Container(
                  height: 100 ,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Course content : ${widget._course.content}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ) ,

              Card(
                margin: const EdgeInsets.all(10.0),
                elevation: 10.0 ,
                child: Container(
                  height: 100 ,
                  child: Center(
                    child: Text(
                      "${widget._course.hour}  hours",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
