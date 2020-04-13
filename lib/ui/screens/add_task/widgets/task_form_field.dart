import 'package:flutter/material.dart';

import '../../../../constants.dart';

class TaskFormField extends StatelessWidget {
  final String fieldTitle;
  final IconData fieldIcon;
  final Widget formWidget;
  final double padding;
  final Function validator;
  final Function onSaved;

  TaskFormField(
      {@required this.fieldTitle,
      this.fieldIcon,
      this.formWidget,
      this.validator,
      this.onSaved,
      this.padding = 12});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 4,
        right: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            fieldTitle,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: formWidget != null
                ? Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: formWidget,
                          ),
                        ],
                      ),
                    ],
                  )
                : TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        fieldIcon,
                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(12),
                    ),
                    validator: validator,
                    onSaved: onSaved,
                    style: Constants.FORM_INPUT_TEXT_STYLE,
                  ),
          ),
        ],
      ),
    );
  }
}
