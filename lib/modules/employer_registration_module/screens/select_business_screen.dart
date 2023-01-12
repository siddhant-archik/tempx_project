import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/modules/employer_registration_module/bloc/get_business_list_bloc.dart';
import 'package:tempx_project/common_models/business_industry_list_model.dart';
import 'package:tempx_project/modules/employer_registration_module/screens/mobile_registration_screen.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class SelectBusinessScreen extends StatefulWidget {
  final Business? alreadySelectedBusiness;
  const SelectBusinessScreen({super.key, this.alreadySelectedBusiness});

  @override
  State<SelectBusinessScreen> createState() => _SelectBusinessScreenState();
}

class _SelectBusinessScreenState extends State<SelectBusinessScreen> {
  var isChecked;
  var businessId;
  late List<Business> businessesList;

  Helpers helper = Helpers();
  @override
  void initState() {
    BlocProvider.of<GetBusinessListBloc>(context).add(GetBusinessListEvent());
    if (widget.alreadySelectedBusiness != null) {
      isChecked = widget.alreadySelectedBusiness!.businessId;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Linking Business',
          style: montserrat600.copyWith(fontSize: 20, color: defaultLightBlue),
        ),
      ),
      body: BlocListener(
        bloc: BlocProvider.of<GetBusinessListBloc>(context),
        listener: (context, state) {
          if (state is GetBusinessListSuccessState) {
            businessesList = state.businessList;
            businessesList.sort(((a, b) {
              return a.legalBusinessName
                  .toLowerCase()
                  .compareTo(b.legalBusinessName.toLowerCase());
            }));
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/landing_page_bg.jpeg',
                opacity: const AlwaysStoppedAnimation(.6),
              ),
              BlocBuilder<GetBusinessListBloc, GetBusinessListState>(
                  builder: (context, state) {
                if (state is GetBusinessListLoadingState) {
                  return const SpinKitFadingFour(
                    color: defaultDarkBlue,
                  );
                } else if (state is GetBusinessListSuccessState) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(3, 15, 3, 18),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Card(
                          elevation: 2,
                          color: const Color(0xffFFFFFF).withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: secondaryBorderColor, width: 1.5),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 33.0),
                                  child: Center(
                                      child: Text(
                                    'Please Select your Business',
                                    style: montserrat500.copyWith(
                                        fontSize: 20, color: Colors.black),
                                  )),
                                ),
                                Center(
                                    child: Text(
                                  'Name by Searching It',
                                  style: montserrat500.copyWith(
                                      fontSize: 20, color: Colors.black),
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, top: 25.0),
                                  child: Text(
                                    'Enter the Business Name',
                                    style: montserrat400.copyWith(
                                        fontSize: 20, color: defaultDarkBlue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Material(
                                          elevation: 5,
                                          // shadowColor:
                                          //     const Color.fromRGBO(54, 67, 115, 0.15),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: TextField(
                                            onChanged: (value) {
                                              if (value.trimRight().isEmpty) {
                                                businessesList =
                                                    state.businessList;
                                              } else {
                                                final filteredList = state
                                                    .businessList
                                                    .where((element) {
                                                  return element
                                                      .legalBusinessName
                                                      .toLowerCase()
                                                      .contains(value
                                                          .toLowerCase()
                                                          .trimRight());
                                                }).toList();
                                                List<Business> temp =
                                                    filteredList;
                                                businessesList = temp;
                                              }
                                              setState(() {});
                                            },
                                            style:
                                                const TextStyle(fontSize: 20),
                                            decoration: defaultTextFieldDecoration
                                                .copyWith(
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    counterText: "",
                                                    suffixIcon: const Icon(Icons
                                                        .close),
                                                    hintText: 'XYZ',
                                                    hintStyle: GoogleFonts
                                                        .montserrat(
                                                            color:
                                                                textFieldHintTextLightBlue,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 20)),
                                          ),
                                        ),
                                      ),
                                      DefaultBlueButton(
                                          buttonTextColor: lightBlueFillColor,
                                          buttonText: 'Go',
                                          height: 60,
                                          onPress: () {},
                                          width: 107)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, top: 25.0, bottom: 10),
                                  child: Text(
                                    'Select your Business Name',
                                    style: montserrat500.copyWith(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: helper.getWidth(context, 360),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: defaultButtonBlue)),
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: businessesList.length,
                                    padding: const EdgeInsets.fromLTRB(
                                        25, 25, 25, 0),
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 18.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  '${businessesList[index].legalBusinessName}, ${businessesList[index].addrL1}',
                                                  style: montserrat400.copyWith(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Checkbox(
                                                value: isChecked ==
                                                        businessesList[index]
                                                            .businessId
                                                    ? true
                                                    : false,
                                                checkColor: defaultButtonBlue,
                                                side: AlwaysActiveBorderSide(),
                                                fillColor: MaterialStateColor
                                                    .resolveWith(
                                                  (states) {
                                                    return Colors.white;
                                                  },
                                                ),
                                                onChanged: ((value) {
                                                  if (isChecked ==
                                                      businessesList[index]
                                                          .businessId) {
                                                    isChecked = '';
                                                    setState(() {});
                                                  } else {
                                                    isChecked =
                                                        businessesList[index]
                                                            .businessId;
                                                    setState(() {});
                                                    Navigator.pop(context,
                                                        businessesList[index]);
                                                  }
                                                }),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }))
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close, size: 35)),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
