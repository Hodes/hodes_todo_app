import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hodes_todo_app/model/todo_item.dart';

typedef TODOListItemCallback = void Function(TODOItem todoItem);

class TODOListItem extends StatefulWidget {
  TODOListItem(
      {required this.item,
      required this.index,
      this.onStateChange,
      this.onEdit,
      this.onDelete,
      this.color})
      : super(key: ObjectKey(item));
  final TODOItem item;
  final int index;
  final TODOListItemCallback? onStateChange;
  final TODOListItemCallback? onEdit;
  final TODOListItemCallback? onDelete;
  final Color? color;

  @override
  _TODOListItemState createState() => _TODOListItemState();
}

class _TODOListItemState extends State<TODOListItem> {
  @override
  void initState() {
    super.initState();
  }

  toggleItemState() {
    setState(() {
      widget.item.done = !widget.item.done;
      widget.onStateChange?.call(widget.item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onLongPress: Feedback.wrapForLongPress(
                  () => widget.onEdit?.call(widget.item), context),
              enableFeedback: true,
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: widget.item.done,
                  tileColor: widget.color,
                  title: Text(widget.item.description!),
                  onChanged: (bool? selected) {
                    toggleItemState();
                  }),
            ),
          ),
          ReorderableDragStartListener(
            index: widget.index,
            child: SizedBox(
              width: 40,
              child: Icon(Icons.drag_handle),
            ),
          )
        ],
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => widget.onDelete?.call(widget.item),
        ),
      ],
    );
  }
}
