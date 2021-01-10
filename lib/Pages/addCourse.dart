import 'package:flutter/material.dart';
import 'package:flutter_sqlite_inro/DataBases/dbBuilder.dart';
import 'package:flutter_sqlite_inro/Models/course.dart';

class AddCourse extends StatefulWidget {

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  String name , content ;
  int hours ;
  var formKey = GlobalKey<FormState>() ;
  var scaffoldKey = GlobalKey<ScaffoldState>() ;
  DbBuilder _builder ;
  @override
  void initState() {
    _builder  = DbBuilder.getInstance() ;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey ,
      appBar: AppBar(
        title: Text("Add Course"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formKey ,
              child: Column(
                children: [
                  SizedBox(height: 23,) ,
                  // course name field >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter the course name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if(value.isEmpty){
                        return "this field is required" ;
                      }
                      return null ;
                    },
                    onChanged: (newValue) {
                      setState(() {
                        name = newValue ;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // course content field >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                  TextFormField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: "Enter the content",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return "this field is required" ;
                      }
                      return null ;
                    },
                    onChanged: (newValue) {
                      setState(() {
                        content = newValue ;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // course time field >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter the course hours",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return "this field is required" ;
                      }
                      return null ;
                    },
                    onChanged: (newValue) {
                      setState(() {
                        hours = int.parse(newValue) ;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // the submit button
                  RaisedButton(
                      child: Text(
                        "Add Course",
                        style: TextStyle(
                          color: Colors.white ,
                          fontSize: 18 ,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      color: Colors.blue,
                      onPressed: (){
                        if(formKey.currentState.validate()){
                            var course = Course({'name' : name  , 'content':content , 'hour':hours}) ;
                             _builder.insertCourse(course) ;
                            Navigator.of(context).pop();
                          }else {
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                  content: Text("there are some errors in the entered data") ,
                                )
                            );
                          }
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
