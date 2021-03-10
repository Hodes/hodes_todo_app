import 'package:flutter/material.dart';

Widget? createDefaultLoaderPlaceholder() => Center(
  child:   Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20,),
          Text("Loading...", style: TextStyle(
            fontSize: 22
          ),),
        ],
      ),
);

class LoadingPlaceholder extends StatefulWidget {
  final bool loading;
  final Widget? placeholder;
  final Widget? child;

  const LoadingPlaceholder(
      {Key? key,
      required this.loading,
      required this.child,
        this.placeholder})
      :super(key: key);

  @override
  _LoadingPlaceholderState createState() => _LoadingPlaceholderState();
}

class _LoadingPlaceholderState extends State<LoadingPlaceholder> {
  chooseContent() {
    if (widget.loading) {
      return widget.placeholder ?? createDefaultLoaderPlaceholder();
    } else {
      return widget.child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: chooseContent(),
    );
  }
}
