import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/custom-widget/circleIcon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskType extends StatefulWidget {
  final Function onTap;

  const AddTaskType({this.onTap});

  @override
  _AddTaskTypeState createState() => _AddTaskTypeState();
}

class _AddTaskTypeState extends State<AddTaskType> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  TextEditingController _txtTask = TextEditingController();
  FocusNode textFieldFocusNode = FocusNode();
  AnimationController _controller;
  Animation _animation;

  bool _isTap = false;
  bool _isEmpty = true;
  double _opacity = 0.0;
  List _listTaskType = [];

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {})
      ..addStatusListener((status) {});
    super.initState();
  }

  dismissKeyboard() {
    textFieldFocusNode.unfocus();
    textFieldFocusNode.canRequestFocus = false;
  }

  _buildTaskTypeItem(int index, Animation<double> animation, String txt) {
    return SlideTransition(
        position: Tween(begin: Offset(1, 0), end: Offset.zero).animate(animation),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30), color: Color(0xff424242)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(
                      txt,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  CircleIcon(
                      onTap: () {
                        _removeItem(index);
                        print("list length ${_listTaskType.length}");
                      },
                      child: Icon(FeatherIcons.x))
                ],
              ),
            ),
            SizedBox(width: 10)
          ],
        ));
  }

  _addItem() {
    listKey.currentState.insertItem(_listTaskType.length, duration: Duration(milliseconds: 300));
    _listTaskType.add(_txtTask.text);
    _txtTask.clear();
  }

  _removeItem(int index) {
    setState(() {
      listKey.currentState.removeItem(index, (context, animation) {
        return Row(
          children: [
            AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: animation.value,
                child: _listTaskType.isEmpty ? Container() : _buildTaskTypeItem(index, animation, _listTaskType[index])),
            SizedBox(width: 10)
          ],
        );
      });
      _listTaskType.removeAt(index);
    });
  }

  _closeEditText() {
    _controller.repeat(reverse: true);
    _isTap = !_isTap;
    _isEmpty = true;
  }

  Widget buildInput() {
    return TextField(
      controller: _txtTask,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      onChanged: (String text) {
        if (_txtTask.text == "") {
          setState(() {
            _isEmpty = true;
            _opacity = 0.0;
          });
        } else
          setState(() {
            _isEmpty = false;
            _opacity = 1;
          });
      },
      focusNode: textFieldFocusNode,
      decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.transparent)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintText: "Type task",
          suffixIcon: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _isEmpty ? 0 : 1,
              child: CircleIcon(
                  tooltip: "Add task type",
                  onTap: () {
                    setState(() {
                      dismissKeyboard();
                      _closeEditText();
                      _addItem();
                    });
                  },
                  child: Icon(FeatherIcons.check))),
          hintStyle: TextStyle(fontSize: 20)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _txtTask.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _listTaskType.isNotEmpty ? 1 : 0,
            child: Container(
              height: _listTaskType.isNotEmpty ? 50 : 0,
              width: Get.width,
              alignment: Alignment.center,
              // remove glow when max scroll listview
              child: ScrollConfiguration(
                behavior: ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.left),
                child: AnimatedList(
                    key: listKey,
                    initialItemCount: _listTaskType.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index, animation) =>
                        _buildTaskTypeItem(index, animation, _listTaskType[index])),
              ),
            ),
          ),
          //_listTaskType.length > 0 ? SizedBox(height: 5) : SizedBox(height: 0),
          Opacity(
            opacity: _isTap ? 1 : 0,
            child: AnimatedContainer(
              constraints: BoxConstraints(maxWidth: Get.width, maxHeight: 50),
              width: _isTap ? Get.width : 0,
              height: _isTap ? 50 : 0,
              curve: Curves.ease,
              duration: Duration(milliseconds: 500),
              child: buildInput(),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              setState(() {
                _controller.forward();
                _isTap = !_isTap;
              });
              return widget.onTap();
            },
            child: Container(
              width: 100,
              height: 50,
              //padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Icon(FeatherIcons.plusCircle), SizedBox(width: 10), Text("Add task")],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
