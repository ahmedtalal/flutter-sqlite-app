import 'package:flutter/material.dart';
import 'package:flutter_sqlite_inro/DataBases/dbBuilder.dart';
import 'package:flutter_sqlite_inro/Models/course.dart';
import 'package:flutter_sqlite_inro/Pages/addCourse.dart';
import 'package:flutter_sqlite_inro/Pages/courseDetails.dart';
import 'package:flutter_sqlite_inro/Pages/updateCourse.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbBuilder _builder;
  TextEditingController _teSearch = TextEditingController() ;
  var _list = List();
  var _itemList = List() ;

  @override
  void initState() {
    super.initState();
    _builder = DbBuilder.getInstance();
     getAllCourses() ;
  }

getAllCourses(){
   _builder.retrieveCourses().then((value) {
      setState(() {
        _list = value;
        _itemList = _list ;
      });
    });
}

// flitter all courses then return the result of fiteration
  void filterSearch(String query){
    var dummySearchList = _list ;
    if (query.isNotEmpty) {
      var dummyListData = List() ;
      dummySearchList.forEach((element) {
        if (element.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(element) ;
        }
      });
      setState(() {
        _itemList = [] ;
        _itemList.addAll(dummyListData) ;
      });
    } else {
      setState(() {
        _itemList = [] ;
        _itemList = _list ;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Courses"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCourse()));
              },
            ),
          ],
        ),
        body: showData()
        );
  }

  // return all courses then show them in the widget
  Widget showData() {
    if (_itemList != null && _itemList.length > 0) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value){
                setState(() {
                  filterSearch(value) ;
                });
              },
              controller: _teSearch ,
              decoration: InputDecoration(
                hintText: "Search" ,
                labelText: "Search" ,
                prefixIcon: Icon(Icons.search ) ,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30) ,
                ),
              ),
            ),
          ) ,

          Expanded(
            child: ListView.builder(
              itemCount: _itemList.length,
              itemBuilder: (context, index) {
                Course course = _itemList[index];
                return Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(

                    title: Text(
                      '${course.name} - ${course.hour} hours',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text(
                      course.content,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.blueGrey,
                      ),
                    ),

                    trailing: Column(
                      children: [
                        // delete button
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 23,
                            ),
                            onPressed: () {
                              setState(() {
                                _builder.deleteCourse(course.id);
                              });
                            },
                          ),
                        ),

                        // edit button
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                              size: 23,
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => UpdateCourse(course)),
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => CourseDetails(course)));
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: Container(
          height: 200 ,
          child: Column(
            children: [
              Icon(
                Icons.hourglass_empty,
                color: Colors.blue,
                size: 100,
              ),
              Text(
                "No courses at this time",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
