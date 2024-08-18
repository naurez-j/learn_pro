import 'package:flutter/material.dart';

import '../../../utils/app_styles.dart';

class CourseTemplate extends StatefulWidget {
  final int id;
  final String preImageIcon;
  final String title;
  final String description;
  String? instructor;
  VoidCallback? onEditTap;
  VoidCallback? onDeleteTap;
  VoidCallback? onEnrollTap;
  VoidCallback? onBoxClick;

  CourseTemplate({
    super.key,
    required this.description,
    required this.title,
    required this.id,
    required this.preImageIcon,
    this.instructor,
    this.onDeleteTap,
    this.onEditTap,
    this.onEnrollTap,
    this.onBoxClick,
  });

  @override
  State<CourseTemplate> createState() => _CourseTemplateState();
}

class _CourseTemplateState extends State<CourseTemplate> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onBoxClick!=null?widget.onBoxClick!():(){};
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color(0xff1f1c1c),
                  Color(0xff2a2727),
                ]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(widget.preImageIcon),
                      width: 50,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: AppStyles.whiteBold20,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          Text(
                            widget.description,
                            style: AppStyles.white14,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          widget.instructor != null
                              ? Text(
                                  'Instructor: ${widget.instructor}',
                                  style: AppStyles.white14
                                      .copyWith(color: Colors.yellow),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              widget.onEnrollTap != null
                  ? IconButton(
                      onPressed: () {
                        widget.onEnrollTap!();
                      },
                      icon: const Icon(
                        Icons.key,
                        color: Colors.lightGreenAccent,
                      ),
                    )
                  : Container(),
              widget.onEditTap != null
                  ? IconButton(
                      onPressed: () {
                        widget.onEditTap!();
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.yellow,
                      ),
                    )
                  : Container(),
              widget.onDeleteTap != null
                  ? IconButton(
                      onPressed: () {
                        widget.onDeleteTap!();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
