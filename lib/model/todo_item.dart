
class TODOItem {
  int id;
  String description;
  bool done;

  TODOItem({this.id, this.description, this.done = false});

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'done': done,
    };
  }
}