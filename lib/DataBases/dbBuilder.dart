import 'package:flutter_sqlite_inro/Models/course.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbBuilder {
  static DbBuilder _builder ;
  static Database _db ;
  static const String _CREATETABLE = 'create table Courses(id integer primary key autoincrement , name varchar(50) , content varchar(200) , hour integer )' ;
  static const String _DBNAME = 'Schools.db' ;
  static const String _TABLENAME = "courses" ;

  static DbBuilder getInstance(){
    if(_builder ==  null){
      return _builder = DbBuilder() ;
    }
    return _builder ;
  }

  // create database
  Future<Database> _createDataBase() async{
    if(_db != null){
      return _db ;
    }
    String path = join( await getDatabasesPath() , _DBNAME) ;
    _db = await openDatabase(path , version: 1 , onCreate:(Database db , int v){
       db.execute(_CREATETABLE) ;
    });
    return _db ;
  }

  // insert data in the table >>>>>>>>>>>>>>>>>>>>>
  Future<int> insertCourse(Course course) async{
    Database db = await _createDataBase();
    return db.insert(_TABLENAME, course.toMap()) ;
  }

  // retrieve all courses from the table >>>>>>>>>>>>>>>
  Future<List<Course>> retrieveCourses() async{
    Database db = await _createDataBase() ;
    List<Map<String , dynamic>> map = await db.query(_TABLENAME) ;
    List<Course> list  = List() ;
    map.forEach((element) {
      Course course = Course.fromMap(element) ;
      list.add(course) ;
    }) ;
    return list ;
  }

  // delete course from table >>>>>>>>>>>>>>>>>
  Future<int> deleteCourse(int id) async{
    Database db = await _createDataBase();
    return db.delete(_TABLENAME , where: 'id = ?' , whereArgs: [id]) ;
  }

  // update course  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<int> updateCourse(Course course) async {
    Database db = await _createDataBase();
    return db.update(_TABLENAME, course.toMap() , where: 'id = ?' , whereArgs: [course.id]) ;
  }
}