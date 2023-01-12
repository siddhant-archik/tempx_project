import 'package:flutter/material.dart';
import 'package:tempx_project/utils/konstants.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarText;
  final bool leadingVisiblity;
  const DefaultAppBar(
      {super.key, required this.appBarText, required this.leadingVisiblity});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: MediaQuery.of(context).size,
        child: AppBar(
          centerTitle: true,
          leading: Visibility(
            visible: leadingVisiblity,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: defaultLightBlue,
                size: 30,
              ),
            ),
          ),
          title: Text(
            appBarText,
            style:
                montserrat500.copyWith(fontSize: 20, color: defaultLightBlue),
          ),
        ));
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}
