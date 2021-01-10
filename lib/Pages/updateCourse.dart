import 'package:flutter/material.dart';
import 'package:flutter_sqlite_inro/DataBases/dbBuilder.dart';
import 'package:flutter_sqlite_inro/Models/course.dart';

// ignore: must_be_immutable
class UpdateCourse extends StatefulWidget {
  Course _course ;
  UpdateCourse(this._course) ;

  @override
  _UpdateCourseState createState() => _UpdateCourseState();
}

class _UpdateCourseState extends State<UpdateCourse> {
  DbBuilder _builder ;
  TextEditingController teName = TextEditingController() ;
  TextEditingController teContent = TextEditingController() ;
  TextEditingController teHour = TextEditingController() ;

  @override
  void initState() {
    _builder = DbBuilder.getInstance() ;
    teName.text = widget._course.name ;
    teContent.text = widget._course.content ;
    teHour.text = widget._course.hour.toString() ;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update course "),
        actions: [
          IconButton(
            icon: Icon(Icons.edit , size: 23,), 
            onPressed: (){
              setState(() {
                Course course = Course({
                  'id' : widget._course.id ,
                  'name' : teName.text ,
                  'content' : teContent.text ,
                  'hour' : int.parse(teHour.text)  
                });
                _builder.updateCourse(course) ;
                Navigator.of(context).pop() ;
              });
            } ,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [

            SizedBox(height: 15,) ,

            TextField(
              controller: teName ,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10) ,
                  borderSide: BorderSide(color: Colors.blue , width: 2) ,
                ) ,
              ),
            ) ,

            SizedBox(height: 15,) ,

            TextField(
              controller: teContent ,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10) ,
                  borderSide: BorderSide(color: Colors.blue , width: 2) ,
                ) ,
              ),
            ) ,

            SizedBox(height: 15,) ,

            TextField(
              controller: teHour ,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10) ,
                  borderSide: BorderSide(color: Colors.blue , width: 2) ,
                ) ,
              ),
            ) ,
          ],
        ),
      ),
    );
  }
}