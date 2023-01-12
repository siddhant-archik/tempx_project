import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tempx_project/common_blocs/get_business_list_bloc.dart';
import 'package:tempx_project/common_blocs/get_store_by_province_bloc.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/common_models/business_list_model.dart';
import 'package:tempx_project/modules/store_manager_registration_module/bloc/register_manager_bloc.dart';
import 'package:tempx_project/modules/store_manager_registration_module/screens/select_store_location_screen.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class LinkBusinessScreen extends StatefulWidget {
  final String name;
  final String email;
  final String mobileNo;
  const LinkBusinessScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.mobileNo});

  @override
  State<LinkBusinessScreen> createState() => _LinkBusinessScreenState();
}

class _LinkBusinessScreenState extends State<LinkBusinessScreen> {
  Helpers helper = Helpers();
  List<String> businessNames = [
    "xyza International Limited Montreal",
    "XYZ International Limited",
    "XYZ International LimitedToronto"
  ];

  bool showBusinessListCard = false;
  var isChecked;
  double buttonOpacity = 0.4;
  bool dataInitialized = false;
  ScrollController businessListViewScrollBar = ScrollController();
  TextEditingController businessNameController = TextEditingController();
  String businessName = '';
  late List<BusinessListModel> businessList;
  late List<BusinessListModel> tempBusinessList;

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<GetBusinessListBloc>(context).add(GetBusinessListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocListener<GetBusinessListBloc, GetBusinessListState>(
        listener: (context, state) {
          if (state is GetBusinessListSuccessState) {
            businessList = state.businessList;
            tempBusinessList = businessList;
            dataInitialized = true;
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: defaultLightBlue,
                size: 30,
              ),
            ),
            title: Text(
              'Linking Business',
              style:
                  montserrat600.copyWith(fontSize: 20, color: defaultLightBlue),
            ),
          ),
          body: Stack(
            children: [
              Image.asset(
                'assets/images/landing_page_bg.jpeg',
                opacity: const AlwaysStoppedAnimation(.33),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: helper.getHeight(context, 35)),
                      child: Center(
                        child: Text(
                          'You have successfully',
                          style: montserrat500.copyWith(
                              fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Registered on TempX as',
                        style: montserrat500.copyWith(
                            fontSize: 20, color: Colors.black),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Store Manager',
                        style: montserrat500.copyWith(
                            fontSize: 20, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: helper.getHeight(context, 53)),
                      child: Center(
                        child: Text(
                          'Please enter the Name',
                          style: montserrat400.copyWith(
                              fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'of the Business for linking it',
                        style: montserrat400.copyWith(
                            fontSize: 20, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: helper.getHeight(context, 19),
                          left: helper.getWidth(context, 23)),
                      child: Text(
                        'Business Name',
                        style: montserrat400.copyWith(
                            fontSize: 20, color: defaultDarkBlue),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: helper.getHeight(context, 5),
                          left: helper.getWidth(context, 8),
                          right: helper.getWidth(context, 8)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Material(
                              elevation: 15,
                              shadowColor:
                                  const Color.fromRGBO(54, 67, 115, 0.15),
                              borderRadius: BorderRadius.circular(30),
                              child: TextField(
                                controller: businessNameController,
                                onChanged: (value) {
                                  businessList = tempBusinessList.where(
                                    (element) {
                                      if (element.legalBusinessName!
                                          .toLowerCase()
                                          .contains(
                                              value.toLowerCase().trim())) {
                                        return element.legalBusinessName!
                                            .toLowerCase()
                                            .contains(
                                                value.toLowerCase().trim());
                                      } else {
                                        return false;
                                      }
                                    },
                                  ).toList();

                                  setState(() {});
                                  validator();
                                },
                                style: const TextStyle(fontSize: 20),
                                decoration: defaultTextFieldDecoration.copyWith(
                                    contentPadding: const EdgeInsets.all(20),
                                    counterText: "",
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          businessNameController.text = '';
                                          validator();
                                        },
                                        child: const Icon(Icons.close)),
                                    hintText: 'Enter Business Name',
                                    filled: true,
                                    fillColor: textFieldFillColor,
                                    hintStyle: GoogleFonts.montserrat(
                                        color: textFieldHintTextLightBlue,
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20)),
                              ),
                            ),
                          ),
                          DefaultBlueButton(
                              buttonTextColor: const Color(0xffF4FBFF),
                              buttonText: 'Go',
                              height: helper.getHeight(context, 60),
                              onPress: () {
                                validator();
                              },
                              width: helper.getWidth(context, 107)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: helper.getHeight(
                              context, showBusinessListCard ? 23 : 260),
                          bottom: helper.getHeight(context, 15)),
                      child: Visibility(
                        visible: showBusinessListCard,
                        child: Center(
                          child: Container(
                            height: helper.getHeight(context, 356),
                            width: helper.getWidth(context, 388),
                            decoration: BoxDecoration(
                                border: Border.all(color: secondaryBorderColor),
                                borderRadius: BorderRadius.circular(35)),
                            child: dataInitialized == false
                                ? noBusinessFoundContainer(context)
                                : businessList.isNotEmpty
                                    ? businessListContainer(context)
                                    : noBusinessFoundContainer(context),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultBlueButton(
                            opacity: buttonOpacity,
                            buttonText: 'Next',
                            height: helper.getHeight(context, 60),
                            onPress: () {
                              if (buttonOpacity == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        BlocProvider<RegisterStoreManagerBloc>(
                                      create: (context) =>
                                          RegisterStoreManagerBloc(),
                                      child: BlocProvider(
                                        create: (context) =>
                                            GetStoreByBusinessListBloc(),
                                        child: SelectManagerStoreLocationScreen(
                                          managerName: widget.name,
                                          managerEmail: widget.email,
                                          mobileNo: widget.mobileNo,
                                          selectedBusinessId: isChecked,
                                          selectedBusinessName: businessName,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            buttonTextColor: secondaryButtonBlue,
                            buttonTextSize: 22,
                            width: helper.getWidth(context, 239)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding noBusinessFoundContainer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: helper.getHeight(context, 83)),
      child: Column(
        children: [
          Text(
            "No Business found for the",
            style: montserrat400.copyWith(
                color: const Color(0xffF95724), fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "entered ",
                style: montserrat400.copyWith(
                    color: const Color(0xffF95724), fontSize: 20),
              ),
              Text(
                "Business-name",
                style: montserrat500.copyWith(
                    color: const Color(0xffF95724), fontSize: 20),
              ),
            ],
          ),
          Text(
            "Please Enter Valid name & Search",
            style: montserrat400.copyWith(
                color: const Color(0xffF95724), fontSize: 20),
          ),
        ],
      ),
    );
  }

  ClipRRect businessListContainer(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35.0),
      child: Scrollbar(
        thickness: 5,
        radius: const Radius.circular(35),
        controller: businessListViewScrollBar,
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: helper.getWidth(context, 18),
                  top: helper.getHeight(context, 25),
                  bottom: helper.getWidth(context, 10),
                ),
                child: Text(
                  'Select your Business Name',
                  style:
                      montserrat500.copyWith(fontSize: 18, color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: helper.getWidth(context, 370),
                    decoration: BoxDecoration(
                        border: Border.all(color: defaultButtonBlue)),
                  ),
                ],
              ),
              ListView.builder(
                  controller: businessListViewScrollBar,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: businessList.length,
                  padding: EdgeInsets.fromLTRB(
                      helper.getWidth(context, 19),
                      helper.getHeight(context, 25),
                      helper.getWidth(context, 30),
                      0),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                businessList[index].legalBusinessName!,
                                style: montserrat400.copyWith(
                                    fontSize: 18, color: Colors.black),
                              )),
                          Expanded(
                            flex: 1,
                            child: Radio(
                              value: businessList[index].businessId,
                              groupValue: isChecked,
                              onChanged: ((value) {
                                isChecked = value;
                                var tempIndex =
                                    tempBusinessList.where((element) {
                                  if (element.businessId == value) {
                                    businessName = element.legalBusinessName!;
                                    setState(() {});
                                    return false;
                                  } else {
                                    return false;
                                  }
                                });
                                print(tempIndex);
                                print("-1-1-1-");
                                print(businessName);
                                buttonOpacity = 1;
                                setState(() {});
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }

  void validator() {
    if (businessNameController.text.trim().isEmpty) {
      showBusinessListCard = false;
    } else {
      showBusinessListCard = true;
    }
    setState(() {});
  }
}
