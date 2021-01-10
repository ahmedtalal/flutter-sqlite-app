class  Course {
  String _name , _content ;
  int _hour , _id;

  Course(dynamic obj){
    _id = obj['id'] ;
    _name = obj['name'] ;
    _content = obj['content'] ;
    _hour = obj['hour'] ;
  }
  Course.fromMap(Map<String , dynamic> data){
    _id = data['id'] ;
    _name = data['name'] ;
    _content = data['content'] ;
    _hour = data['hour'] ;
  }

  Map<String , dynamic> toMap() => {
    'id': _id ,
    'name' : _name ,
    'content' : _content ,
    'hour' : _hour
  };

  get id => _id;

  int get hour => _hour;

  get content => _content;

  String get name => _name;
}