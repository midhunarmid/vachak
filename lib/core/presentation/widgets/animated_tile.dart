import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedClickableTile extends StatefulWidget {
  final bool isActive;
  final String title;
  final Color bgColor;
  final Color bgColorHover;
  final Color textColor;
  final Color textColorHover;
  final VoidCallback press;
  final String description;

  const AnimatedClickableTile({
    Key? key,
    this.isActive = false,
    required this.title,
    required this.press,
    required this.bgColor,
    required this.bgColorHover,
    this.description = "",
    required this.textColor,
    required this.textColorHover,
  }) : super(key: key);

  @override
  State createState() {
    return _AnimatedClickableTileState();
  }
}

class _AnimatedClickableTileState extends State<AnimatedClickableTile> {
  bool isHover = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding:
          EdgeInsets.only(top: (isHover) ? 4 : 5, bottom: !(isHover) ? 4 : 5),
      color: isHover ? widget.bgColorHover : widget.bgColor,
      child: InkWell(
        onHover: (val) => setState(() {
          isHover = val;
        }),
        onFocusChange: (val) => setState(() {
          isHover = val;
        }),
        onTapDown: (detail) => setState(() {
          isHover = true;
        }),
        onTapUp: (detail) => setState(() {
          isHover = false;
        }),
        onTapCancel: () => setState(() {
          isHover = false;
        }),
        child: ListTile(onTap: widget.press, title: getMenuItem()),
      ),
    );
  }

  Widget getMenuItem() {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.bgColorHover,
              borderRadius: BorderRadius.circular(55.0),
            ),
            padding: const EdgeInsets.all(4.0),
            height: 55.0,
            width: 55.0,
            child: Center(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: (widget.isActive || isHover)
                          ? widget.textColorHover
                          : widget.textColor,
                    ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            widget.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10.sp,
                  color: (widget.isActive || isHover)
                      ? widget.textColorHover
                      : widget.textColor,
                ),
          ),
        ],
      ),
    );
  }
}
