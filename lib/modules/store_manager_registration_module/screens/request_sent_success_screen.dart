import 'package:flutter/material.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class LinkStoreRequestSentSuccessScreen extends StatefulWidget {
  final String businessName;
  final List<String> storeAddress;
  const LinkStoreRequestSentSuccessScreen(
      {super.key, required this.businessName, required this.storeAddress});

  @override
  State<LinkStoreRequestSentSuccessScreen> createState() =>
      _LinkStoreRequestSentSuccessScreenState();
}

class _LinkStoreRequestSentSuccessScreenState
    extends State<LinkStoreRequestSentSuccessScreen> {
  Helpers helper = Helpers();
  @override
  Widget build(BuildContext context) {
    print(widget.businessName);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Link Stores',
          style: montserrat600.copyWith(fontSize: 20, color: defaultLightBlue),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/landing_page_bg.jpeg',
            opacity: const AlwaysStoppedAnimation(.33),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: helper.getHeight(context, 40)),
                child: Center(
                  child: Text(
                    'Your request for linking',
                    style: montserrat500.copyWith(
                        fontSize: 20, color: defaultDarkBlue),
                  ),
                ),
              ),
              Text(
                'the below store',
                style: montserrat500.copyWith(
                    fontSize: 20, color: defaultDarkBlue),
              ),
              Text(
                'has been sent',
                style: montserrat500.copyWith(
                    fontSize: 20, color: defaultDarkBlue),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: helper.getHeight(context, 28),
                    bottom: helper.getHeight(context, 33),
                    left: helper.getWidth(context, 12),
                    right: helper.getWidth(context, 12)),
                child: Container(
                  width: helper.getWidth(context, 396),
                  height: helper.getHeight(context, 250),
                  decoration: BoxDecoration(
                      border: Border.all(color: secondaryBorderColor),
                      // color: Colors.white,
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(35)),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: helper.getHeight(context, 40)),
                        child: Text(
                          widget.businessName,
                          style: montserrat500.copyWith(
                              fontSize: 20, color: defaultDarkBlue),
                        ),
                      ),
                      const Divider(
                        color: defaultDarkBlue,
                        thickness: 1,
                        endIndent: 10,
                        indent: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: helper.getHeight(context, 15)),
                          child: ListView.builder(
                            itemCount: widget.storeAddress.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Center(
                                  child: Text(
                                widget.storeAddress[index],
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: montserrat400.copyWith(
                                    fontSize: 20, color: defaultDarkBlue),
                              ));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Please wait for Approval',
                style: montserrat400.copyWith(
                    fontSize: 20, color: defaultDarkBlue),
              ),
              Text(
                'from the Employer',
                style: montserrat400.copyWith(
                    fontSize: 20, color: defaultDarkBlue),
              )
            ],
          ),
        ],
      ),
    );
  }
}
