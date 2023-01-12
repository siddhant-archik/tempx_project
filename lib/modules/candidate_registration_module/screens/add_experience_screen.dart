import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tempx_project/common_blocs/get_city_by_province_bloc.dart';
import 'package:tempx_project/common_blocs/get_provinces_bloc.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/common_components/default_textfield.dart';
import 'package:tempx_project/common_models/provinces_list_model.dart';
import 'package:tempx_project/modules/candidate_registration_module/models/candidate_registration_model.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddExperienceScreen extends StatefulWidget {
  final CandidateExperienceModel? editExpData;
  final List<Province>? provinceForAddExp;
  const AddExperienceScreen(
      {super.key, this.editExpData, this.provinceForAddExp});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  Helpers helper = Helpers();
  int workedToggleValue = 1;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  String fromYear = '';
  String tillYear = '';

  var expProvinceValue;
  var cityByProvienceValue;

  @override
  void initState() {
    print(widget.provinceForAddExp);
    if (widget.provinceForAddExp == null) {
      print('NO PRO');
      BlocProvider.of<GetProvinceListBloc>(context).add(GetProvinceListEvent());
    }
    if (widget.editExpData != null) {
      companyNameController.text = widget.editExpData!.companyName;
      designationController.text = widget.editExpData!.designation;
      fromYear = widget.editExpData!.startYear;
      tillYear = widget.editExpData!.endYear;
      workedToggleValue = widget.editExpData!.workedInCanada == true ? 1 : 0;
      // provinceValue = widget.editExpData!.province;
      setState(() {});
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: lightBlueFillColor,
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
          'Candidate Registration',
          style: montserrat500.copyWith(fontSize: 20, color: defaultLightBlue),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.only(
                top: helper.getHeight(context, 20),
                left: helper.getWidth(context, 2),
                right: helper.getWidth(context, 2),
                bottom: helper.getWidth(context, 30),
              ),
              elevation: 0,
              color: const Color(0xffFFFFFF).withOpacity(0),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: secondaryBorderColor, width: 1.5),
                borderRadius: BorderRadius.circular(21.0),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: helper.getWidth(context, 8),
                      left: helper.getWidth(context, 8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: helper.getHeight(context, 27)),
                          child: Center(
                              child: Text(
                            'Add Experience',
                            style: montserrat500.copyWith(
                                fontSize: 20, color: defaultDarkBlue),
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: helper.getHeight(context, 24),
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                          ),
                          child: Text(
                            'Add Company Name',
                            style: montserrat400.copyWith(
                                fontSize: 18, color: defaultDarkBlue),
                          ),
                        ),
                        DefaultTextField(
                            controller: companyNameController,
                            devHeight: devHeight,
                            hintText: 'XYZ',
                            onChanged: (value) {}),
                        Padding(
                          padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 10),
                          ),
                          child: Text(
                            'Designation',
                            style: montserrat400.copyWith(
                                fontSize: 18, color: defaultDarkBlue),
                          ),
                        ),
                        DefaultTextField(
                            controller: designationController,
                            devHeight: devHeight,
                            hintText: '',
                            onChanged: (value) {}),
                        Padding(
                          padding: EdgeInsets.only(
                              left: helper.getWidth(context, 15),
                              right: helper.getWidth(context, 15),
                              bottom: helper.getHeight(context, 15),
                              top: helper.getHeight(context, 15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Worked in Canada ?',
                                style: montserrat400.copyWith(
                                    fontSize: 18, color: defaultDarkBlue),
                              ),
                              ToggleSwitch(
                                cornerRadius: 30.0,
                                activeBgColor: const [Color(0xff5D6B9F)],
                                inactiveBgColor: const Color(0xffD9E0FA),
                                customWidths: const [83, 83],
                                minHeight: 50,
                                initialLabelIndex: workedToggleValue,
                                totalSwitches: 2,
                                customTextStyles: [
                                  workedToggleValue == 0
                                      ? montserrat600.copyWith(
                                          color: Colors.white, fontSize: 18)
                                      : montserrat400.copyWith(
                                          color: const Color(0xff667BC3),
                                          fontSize: 18),
                                  workedToggleValue == 1
                                      ? montserrat600.copyWith(
                                          color: Colors.white, fontSize: 18)
                                      : montserrat400.copyWith(
                                          color: const Color(0xff667BC3),
                                          fontSize: 18)
                                ],
                                labels: const ['No', 'Yes'],
                                radiusStyle: true,
                                onToggle: (index) {
                                  workedToggleValue = index!;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                          child: Text(
                            'Location *',
                            style: montserrat400.copyWith(
                                fontSize: 18, color: defaultDarkBlue),
                          ),
                        ),
                        Material(
                          elevation: 15,
                          shadowColor: const Color.fromRGBO(54, 67, 115, 0.15),
                          borderRadius: BorderRadius.circular(30),
                          child: TextField(
                            readOnly: true,
                            onTap: () {},
                            onChanged: (value) {},
                            style: const TextStyle(fontSize: 20),
                            decoration: defaultTextFieldDecoration.copyWith(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: textFieldBorderColor),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                contentPadding: devHeight <= 667
                                    ? const EdgeInsets.all(20)
                                    : null,
                                counterText: "",
                                hintText: 'Select Location on Map',
                                filled: true,
                                fillColor: textFieldFillColor,
                                hintStyle: GoogleFonts.montserrat(
                                    color: textFieldHintTextLightBlue,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              'OR',
                              style: montserrat600.copyWith(
                                  fontSize: 20, color: defaultDarkBlue),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: textFieldBorderColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: widget.provinceForAddExp != null
                              ? DropdownButton(
                                  menuMaxHeight: helper.getHeight(context, 300),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  hint: const Text('Province'),
                                  value: expProvinceValue ?? null,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    size: 45,
                                  ),
                                  style: montserrat400.copyWith(
                                      fontSize: 18,
                                      color: const Color(0xff5265A8)),
                                  items: widget.provinceForAddExp!.map((e) {
                                    return DropdownMenuItem(
                                        value: e, child: Text(e.provinceName));
                                  }).toList(),
                                  onChanged: (value) {
                                    expProvinceValue = value;
                                    cityByProvienceValue = null;
                                    setState(() {});
                                    BlocProvider.of<GetCityByProvinceListBloc>(
                                            context)
                                        .add(GetCityByProvinceListEvent(
                                            provinceId: expProvinceValue
                                                .provinceId
                                                .toString()));
                                    // print(provinceValue.provinceName);
                                  },
                                )
                              : BlocBuilder<GetProvinceListBloc,
                                      GetProvinceListState>(
                                  builder: (context, state) {
                                  if (state is GetProvinceListSuccessState) {
                                    return DropdownButton(
                                      menuMaxHeight:
                                          helper.getHeight(context, 300),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      hint: const Text('Province'),
                                      value: expProvinceValue ?? null,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        size: 45,
                                      ),
                                      style: montserrat400.copyWith(
                                          fontSize: 18,
                                          color: const Color(0xff5265A8)),
                                      items: state.provinceList.map((e) {
                                        return DropdownMenuItem(
                                            value: e,
                                            child: Text(e.provinceName));
                                      }).toList(),
                                      onChanged: (value) {
                                        expProvinceValue = value;
                                        cityByProvienceValue = null;
                                        setState(() {});
                                        BlocProvider.of<
                                                    GetCityByProvinceListBloc>(
                                                context)
                                            .add(GetCityByProvinceListEvent(
                                                provinceId: expProvinceValue
                                                    .provinceId
                                                    .toString()));
                                        // print(provinceValue.provinceName);
                                      },
                                    );
                                  } else {
                                    return DropdownButton(
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      hint: const Text('Province'),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        size: 45,
                                      ),
                                      style: montserrat400.copyWith(
                                          fontSize: 18,
                                          color: const Color(0xff5265A8)),
                                      items: <String>[].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    );
                                  }
                                }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: helper.getHeight(context, 10),
                              bottom: helper.getHeight(context, 35)),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: textFieldBorderColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: BlocBuilder<GetCityByProvinceListBloc,
                                    GetCityByProvinceListState>(
                                builder: (context, state) {
                              if (state is GetCityByProvinceListSuccessState) {
                                return DropdownButton(
                                  menuMaxHeight: helper.getHeight(context, 300),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  hint: const Text('City'),
                                  value: cityByProvienceValue ?? null,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    size: 45,
                                  ),
                                  style: montserrat400.copyWith(
                                      fontSize: 18,
                                      color: const Color(0xff5265A8)),
                                  items: state.cityByProvinceList.map((e) {
                                    return DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e.cityName,
                                          // style: TextStyle(
                                          //     fontSize: 19,
                                          //     color: Colors.black),
                                        ));
                                  }).toList(),
                                  onChanged: (value) {
                                    cityByProvienceValue = value;
                                    setState(() {});
                                  },
                                );
                              }
                              return DropdownButton<String>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                hint: const Text('City'),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 45,
                                ),
                                style: montserrat400.copyWith(
                                    fontSize: 18,
                                    color: const Color(0xff5265A8)),
                                items: <String>[].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              );
                            }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: helper.getWidth(context, 8),
                              left: helper.getWidth(context, 8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Text(
                                      'Experience',
                                      style:
                                          montserrat400.copyWith(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Text(
                                      'From (Year)',
                                      style:
                                          montserrat400.copyWith(fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    width: helper.getWidth(context, 188),
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 8, 12, 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD9E0FA),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: DropdownButton<String>(
                                      underline: const SizedBox(),
                                      hint: const Text('2017'),
                                      isExpanded: true,
                                      value: fromYear == '' ? null : fromYear,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        size: 45,
                                      ),
                                      style: montserrat400.copyWith(
                                          fontSize: 18,
                                          color: const Color(0xff5265A8)),
                                      items: <String>[
                                        '2017',
                                        '2018',
                                        '2019',
                                        '2020',
                                        '2021'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        fromYear = value!;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Text(
                                      'Experience',
                                      style:
                                          montserrat400.copyWith(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Text(
                                      'Till (Year)',
                                      style:
                                          montserrat400.copyWith(fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    width: helper.getWidth(context, 188),
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 8, 12, 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD9E0FA),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: DropdownButton<String>(
                                      underline: const SizedBox(),
                                      hint: const Text('2021'),
                                      isExpanded: true,
                                      value: tillYear == '' ? null : tillYear,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        size: 45,
                                      ),
                                      style: montserrat400.copyWith(
                                          fontSize: 18,
                                          color: const Color(0xff5265A8)),
                                      items: <String>[
                                        '2017',
                                        '2018',
                                        '2019',
                                        '2020',
                                        '2021'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        tillYear = value!;
                                        print(value);
                                        print(tillYear);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: helper.getHeight(context, 33),
                              top: helper.getHeight(context, 26)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DefaultBlueButton(
                                  borderRadius: 36,
                                  buttonText: 'Save',
                                  height: helper.getHeight(context, 73),
                                  onPress: () {
                                    saveOnTap();
                                  },
                                  width: helper.getWidth(context, 269)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                        onTap: () {
                          if (widget.editExpData != null) {
                            Navigator.pop(context, widget.editExpData);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: const Icon(Icons.close, size: 35)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveOnTap() {
    CandidateExperienceModel expData = CandidateExperienceModel(
        companyName: companyNameController.text.trim(),
        designation: designationController.text.trim(),
        workedInCanada: workedToggleValue == 0 ? false : true,
        province: expProvinceValue.provinceName,
        city: cityByProvienceValue.cityName,
        startYear: fromYear,
        endYear: tillYear);
    print(expData.startYear);
    Navigator.pop(context, expData);
  }
}
