import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageBalance extends StatefulWidget {
  @override
  _ManageBalanceState createState() => _ManageBalanceState();
}

class _ManageBalanceState extends State<ManageBalance> with SingleTickerProviderStateMixin {
  var _balanceController = TextEditingController();
  var previousText = "";
  @override
  void dispose() {
    super.dispose();
    _balanceController.dispose();
  }

  void setEndCursor() {
    final val = TextSelection.collapsed(offset: _balanceController.text.length);
    _balanceController.selection = val;
  }

  void buildNumber(String value) {
    var text = _balanceController.text;

    print(text);
    print("text length: ${text.length}");
    switch (value.length) {
      case 4:
        {
          setState(() {
            _balanceController.text = text[0] + '.' + text.substring(1);
            previousText = _balanceController.text;
          });
          setEndCursor();
        }
        break;
      case 5:
        {
          setState(() {
            _balanceController.text = previousText;
          });
          setEndCursor();
        }
        break;
      case 6:
        {
          setState(() {
            text = _balanceController.text.replaceFirst(new RegExp(r'.'), '', 1);
            String newText = text.substring(0, 2) + '.' + text.substring(2, text.length);
            print("new text $newText");
            _balanceController.text = newText;
            _balanceController.text = previousText;
          });
          setEndCursor();
        }
        break;
      case 7:
        {
          setState(() {
            text = _balanceController.text.replaceFirst(new RegExp(r'.'), '', 2);
            String newText = text.substring(0, 3) + '.' + text.substring(3, text.length);
            _balanceController.text = newText;
          });
        }
        break;

      case 8:
        // reverse result
        break;

      case 9:
        
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Enter the amount",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "ProductSans-Regular")),
                Spacer(),
                AnimatedOpacity(
                  opacity: 1,
                  duration: Duration(milliseconds: 600),
                  child: CircleIcon(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        FeatherIcons.check,
                        color: Colors.black,
                      )),
                )
              ],
            ),
            SizedBox(height: 15),
            Container(
              width: Get.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: Text("đ",
                          style: TextStyle(
                              fontSize: 20,
                              height: 2,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: _balanceController,
                      style:
                          TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.w900),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        return buildNumber(value);
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: "0",
                        border: InputBorder.none,
                        filled: false,
                        hintStyle: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            /*RangeSlider(
              min: 0,
              max: 100,
              values : RangeValues(0, 100),labels: RangeLabels("start", "end"), onChanged: (value){}),*/
          ],
        ),
      ),
    );
  }
}
