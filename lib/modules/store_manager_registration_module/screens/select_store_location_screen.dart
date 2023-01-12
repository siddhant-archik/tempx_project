import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tempx_project/common_blocs/get_store_by_province_bloc.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/modules/store_manager_registration_module/bloc/register_manager_bloc.dart';
import 'package:tempx_project/modules/store_manager_registration_module/models/register_manager_model.dart';
import 'package:tempx_project/modules/store_manager_registration_module/screens/request_sent_success_screen.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class SelectManagerStoreLocationScreen extends StatefulWidget {
  final int selectedBusinessId;
  final String selectedBusinessName;
  final String mobileNo;
  final String managerName;
  final String managerEmail;
  const SelectManagerStoreLocationScreen(
      {super.key,
      required this.mobileNo,
      required this.managerEmail,
      required this.managerName,
      required this.selectedBusinessId,
      required this.selectedBusinessName});

  @override
  State<SelectManagerStoreLocationScreen> createState() =>
      _SelectManagerStoreLocationScreenState();
}

class _SelectManagerStoreLocationScreenState
    extends State<SelectManagerStoreLocationScreen> {
  Helpers helper = Helpers();
  List<int> isChecked = [];
  List<String> selectedStoresAddrerss = [];
  double buttonOpacity = 0.4;
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<GetStoreByBusinessListBloc>(context).add(
        GetStoreByBusinessListEvent(
            businessId: widget.selectedBusinessId.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterStoreManagerBloc, RegisterStoreManagerState>(
      listener: (context, state) {
        if (state is RegisterStoreManagerSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  LinkStoreRequestSentSuccessScreen(
                businessName: widget.selectedBusinessName,
                storeAddress: selectedStoresAddrerss,
              ),
            ),
          );
        } else if (state is RegisterStoreManagerErrorState) {
          String customMessage = '';

          if (state.err ==
              'Duplicate entry \'${widget.mobileNo}\' for key \'store_manager_profile.contact_number\'') {
            customMessage = 'Already registered mobile number';
          } else if (state.err ==
              'Duplicate entry \'${widget.managerEmail}\' for key \'store_manager_profile.email\'') {
            customMessage = 'Already registered email address';
          }
          setState(() {});
          Fluttertoast.showToast(
              msg: customMessage == '' ? state.err : customMessage,
              backgroundColor: Colors.red[400],
              fontSize: 22,
              timeInSecForIosWeb: 10);
        }
      },
      child: Scaffold(
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
            'Link Stores',
            style:
                montserrat600.copyWith(fontSize: 20, color: defaultLightBlue),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.menu,
                color: defaultLightBlue,
                size: 40,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/landing_page_bg.jpeg',
              opacity: const AlwaysStoppedAnimation(.33),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: helper.getHeight(context, 32)),
                  child: Center(
                    child: Text(
                      'Please select the store Location',
                      style: montserrat500.copyWith(
                          fontSize: 20, color: defaultDarkBlue),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'and Submit',
                    style: montserrat500.copyWith(
                        fontSize: 20, color: defaultDarkBlue),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: helper.getHeight(context, 10),
                      left: helper.getWidth(context, 12),
                      right: helper.getWidth(context, 12)),
                  child: Container(
                    width: helper.getWidth(context, 395),
                    height: helper.getHeight(context, 460),
                    padding: EdgeInsets.only(
                        top: helper.getHeight(context, 50),
                        left: helper.getWidth(context, 12)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: secondaryBorderColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: helper.getWidth(context, 10),
                              bottom: helper.getHeight(context, 10)),
                          child: Text(
                            widget.selectedBusinessName,
                            softWrap: true,
                            style: montserrat500.copyWith(
                                fontSize: 20, color: defaultDarkBlue),
                          ),
                        ),
                        BlocBuilder<GetStoreByBusinessListBloc,
                                GetStoreByBusinessListState>(
                            builder: (context, state) {
                          if (state is GetStoreByBusinessListSuccessState) {
                            return state.storeByBusinessList.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: Text(
                                        'No store found for this business',
                                        style: montserrat400,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          state.storeByBusinessList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            const Divider(
                                              color: defaultDarkBlue,
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  helper.getWidth(context, 10),
                                                  helper.getHeight(context, 10),
                                                  helper.getWidth(context, 10),
                                                  helper.getHeight(
                                                      context, 15)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${state.storeByBusinessList[index].addrL1} ${state.storeByBusinessList[index].addrL2}",
                                                          style: montserrat400
                                                              .copyWith(
                                                                  fontSize: 20),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          "${state.storeByBusinessList[index].city}, ${state.storeByBusinessList[index].province}",
                                                          style: montserrat400
                                                              .copyWith(
                                                                  fontSize: 20),
                                                          softWrap: true,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    value: isChecked.contains(state
                                                            .storeByBusinessList[
                                                                index]
                                                            .storeId)
                                                        ? true
                                                        : false,
                                                    checkColor:
                                                        defaultButtonBlue,
                                                    side:
                                                        AlwaysActiveBorderSide(),
                                                    fillColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                      (states) {
                                                        return Colors.white;
                                                      },
                                                    ),
                                                    onChanged: ((value) {
                                                      if (isChecked.contains(state
                                                          .storeByBusinessList[
                                                              index]
                                                          .storeId)) {
                                                        var indexOfAddress =
                                                            isChecked.indexOf(state
                                                                .storeByBusinessList[
                                                                    index]
                                                                .storeId!);
                                                        selectedStoresAddrerss
                                                            .removeAt(
                                                                indexOfAddress);
                                                        isChecked.remove(state
                                                            .storeByBusinessList[
                                                                index]
                                                            .storeId);
                                                      } else {
                                                        selectedStoresAddrerss.add(
                                                            "${state.storeByBusinessList[index].addrL1} ${state.storeByBusinessList[index].addrL2} ${state.storeByBusinessList[index].city}, ${state.storeByBusinessList[index].province}");
                                                        isChecked.add(state
                                                            .storeByBusinessList[
                                                                index]
                                                            .storeId!);
                                                      }
                                                      validator();
                                                      setState(() {});
                                                    }),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  );
                          } else if (state
                              is GetStoreByBusinessListLoadingState) {
                            return Column(
                              children: const [
                                Center(
                                  child: SpinKitFadingFour(
                                    size: 25,
                                    color: lightDefaultDarkBlue,
                                  ),
                                ),
                                // Text('Fetching Stores');
                              ],
                            );
                          } else if (state
                              is GetStoreByBusinessListErrorState) {
                            return Text(state.err);
                          } else {
                            return Container();
                          }
                        })
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: helper.getHeight(context, 45)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultBlueButton(
                          opacity: buttonOpacity,
                          buttonText: 'Submit',
                          textOrLoader: BlocBuilder<RegisterStoreManagerBloc,
                                  RegisterStoreManagerState>(
                              builder: (context, state) {
                            if (state is RegisterStoreManagerLoadingState) {
                              return const SpinKitFadingFour(
                                color: secondaryButtonBlue,
                              );
                            } else {
                              return Text(
                                'Submit',
                                style: montserrat600.copyWith(
                                    fontSize: 22, color: secondaryButtonBlue),
                              );
                            }
                          }),
                          height: helper.getHeight(context, 60),
                          onPress: () async {
                            if (buttonOpacity == 1) {
                              submitOnClick();
                            }
                          },
                          buttonTextColor: secondaryButtonBlue,
                          buttonTextSize: 22,
                          width: helper.getWidth(context, 239)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submitOnClick() async {
    var deviceId = await helper.getDeviceId();
    RegisterStoreManagerModel storeManagerData = RegisterStoreManagerModel(
        contactNumber: widget.mobileNo,
        deviceId: deviceId,
        email: widget.managerEmail,
        managerName: widget.managerName,
        storeId: isChecked);
    if (!mounted) return;
    BlocProvider.of<RegisterStoreManagerBloc>(context)
        .add(RegisterStoreManagerEvent(storeManagerData: storeManagerData));
  }

  void validator() {
    if (isChecked.isEmpty) {
      buttonOpacity = 0.4;
    } else {
      buttonOpacity = 1;
    }
    setState(() {});
  }
}

class AlwaysActiveBorderSide extends MaterialStateBorderSide {
  @override
  BorderSide? resolve(states) => const BorderSide(color: defaultButtonBlue);
}
