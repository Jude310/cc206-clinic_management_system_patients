import 'package:hinosa_clinic/hinosa_widgets/hinosa_nav_bar.dart';
import 'dart:convert';
import '/hinosa_widgets/hinosa_drop_down.dart';
import '/hinosa_widgets/hinosa_theme.dart';
import '/hinosa_widgets/hinosa_util.dart';
import '/hinosa_widgets/hinosa_widgets.dart';
import '/hinosa_widgets/form_field_controller.dart';
import '/hinosa_widgets/random_data_util.dart' as random_data;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'patients_model.dart';
export 'patients_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class PatientsWidget extends StatefulWidget {
  const PatientsWidget({Key? key}) : super(key: key);

  @override
  _PatientsWidgetState createState() => _PatientsWidgetState();
}

Future<Map<String, dynamic>> findPatient(
    String firstName, String lastName, String middleName) async {
  try {
    final response = await http.get(
      Uri.parse(
          'http://localhost:3001/patients/findPatient?firstName=$firstName&lastName=$lastName&middleName=$middleName'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody;
    } else {
      throw Exception('Failed to find patient');
    }
  } catch (error) {
    print('Error finding patient: $error');
    throw error;
  }
}

class _PatientsWidgetState extends State<PatientsWidget> {
  late PatientsModel _model;
  late Future<List<Map<String, dynamic>>> patientsFuture;
  Map<String, dynamic>? selectedPatient;
  List<Map<String, dynamic>>? appointmentHistory = [];
  void updateParentState() {
    setState(() {
      // Update the state in the parent widget as needed
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PatientsModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textController5 ??= TextEditingController();
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.textController6 ??= TextEditingController();
    _model.textFieldFocusNode6 ??= FocusNode();

    _model.textController7 ??= TextEditingController();
    _model.textFieldFocusNode7 ??= FocusNode();

    _model.textController8 ??= TextEditingController();
    _model.textFieldFocusNode8 ??= FocusNode();

    _model.textController9 ??= TextEditingController();
    _model.textFieldFocusNode9 ??= FocusNode();
    fetchPatients();
  }

  String formatDateTime(String? dateString) {
    if (dateString == null) {
      return '';
    }

    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd MMM yyyy', 'en_US');
    final String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }

  Future<List<Map<String, dynamic>>> fetchAppointments(String patientId) async {
    final appointmentResponse = await http.get(
      Uri.parse('http://localhost:3001/patients/$patientId/appointments'),
    );

    if (appointmentResponse.statusCode == 200) {
      final Map<String, dynamic> responseBody =
          json.decode(appointmentResponse.body);

      // Print the actual response body for debugging
      // print('Actual response body: $responseBody');

      // Check if the response body has "getAppointments" and "patientAppointments"
      if (responseBody.containsKey('getAppointments') &&
          responseBody['getAppointments'] is Map<String, dynamic> &&
          responseBody['getAppointments'].containsKey('patientAppointments') &&
          responseBody['getAppointments']['patientAppointments'] is List) {
        return List<Map<String, dynamic>>.from(
          responseBody['getAppointments']['patientAppointments'],
        );
      } else {
        // Handle the case where the structure is not as expected
        throw Exception('Invalid response format for appointments');
      }
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load appointments');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPatients() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3001/patients'));
      // print("hello")
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        return List<Map<String, dynamic>>.from(responseBody['patientList']);
      } else {
        throw Exception('Failed to load patients');
      }
    } catch (error) {
      print('Error fetching patients: $error');
      throw error;
    }
  }

  Future<void> showEditDialog(
      BuildContext context, Map<String, dynamic> appointment) async {
    TextEditingController reasonController =
        TextEditingController(text: appointment['appointmentReason']);
    DateTime selectedDate = DateTime.parse(appointment['appointmentDate']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Appointment'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    initialDate: selectedDate,
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate.add(Duration(days: 1));
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        'Selected Date: ${DateFormat('dd MMM yyyy').format(selectedDate)}',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('Reason:'),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  hintText: 'Enter appointment reason',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedAppointment = {
                  'appointmentDate': selectedDate.toUtc().toIso8601String(),
                  'appointmentReason': reasonController.text,
                };

                final response = await http.patch(
                  Uri.parse(
                      'http://localhost:3001/appointments/${appointment['_id']}'),
                  body: jsonEncode(updatedAppointment),
                  headers: {'Content-Type': 'application/json'},
                );

                setState(() {
                  appointment['appointmentDate'] =
                      selectedDate.toUtc().toIso8601String();
                  appointment['appointmentReason'] = reasonController.text;
                });

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: HinosaTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 900.0,
                  decoration: BoxDecoration(
                    color: HinosaTheme.of(context).secondaryBackground,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/Hinosa_BG.png',
                      ).image,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 120.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFDFCFD), Color(0x00FFFFFF)],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                          ),
                          child: nav_bar(),
                        ),
                        Container(
                          width: 1440,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    120.0, 40.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 397.0,
                                      height: 370.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 12.0,
                                            color: Color(0x33000000),
                                            offset: Offset(0.0, 5.0),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                          color: Color(0xFF191645),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                                -1.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 24.0, 0.0, 0.0),
                                              child: Text(
                                                'Patients Form',
                                                style: HinosaTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF17171F),
                                                      fontSize: 24.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                -1.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                'Patient Name:',
                                                style: HinosaTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF17171F),
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 120.0,
                                                  height: 35.0,
                                                  decoration: BoxDecoration(
                                                    color: HinosaTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4.0,
                                                        color:
                                                            Color(0x33000000),
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController1,
                                                    focusNode: _model
                                                        .textFieldFocusNode1,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'L. Name',
                                                      labelStyle:
                                                          HinosaTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Color(
                                                                    0xA717171F),
                                                                fontSize: 13.0,
                                                              ),
                                                      hintStyle: HinosaTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 11.0,
                                                          ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: HinosaTheme.of(
                                                                  context)
                                                              .alternate,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF191645),
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: HinosaTheme.of(
                                                                  context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: HinosaTheme.of(
                                                                  context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xFFECECEC),
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  5.0,
                                                                  10.0,
                                                                  5.0),
                                                    ),
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                          fontSize: 13.0,
                                                        ),
                                                    validator: _model
                                                        .textController1Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          2.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 115.0,
                                                    height: 35.0,
                                                    decoration: BoxDecoration(
                                                      color: HinosaTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x33000000),
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController2,
                                                      focusNode: _model
                                                          .textFieldFocusNode2,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'F. Name',
                                                        labelStyle: HinosaTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xA717171F),
                                                              fontSize: 13.0,
                                                            ),
                                                        hintStyle: HinosaTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 11.0,
                                                            ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .primary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xFFECECEC),
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    5.0,
                                                                    10.0,
                                                                    5.0),
                                                      ),
                                                      style: HinosaTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF17171F),
                                                            fontSize: 13.0,
                                                          ),
                                                      validator: _model
                                                          .textController2Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          2.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 74.0,
                                                    height: 35.0,
                                                    decoration: BoxDecoration(
                                                      color: HinosaTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x33000000),
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController3,
                                                      focusNode: _model
                                                          .textFieldFocusNode3,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'M. Name',
                                                        labelStyle: HinosaTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xA717171F),
                                                              fontSize: 13.0,
                                                            ),
                                                        hintStyle: HinosaTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 13.0,
                                                            ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .primary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xFFECECEC),
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    5.0,
                                                                    10.0,
                                                                    5.0),
                                                      ),
                                                      style: HinosaTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF17171F),
                                                            fontSize: 13.0,
                                                          ),
                                                      validator: _model
                                                          .textController3Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          2.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 40.0,
                                                    height: 35.0,
                                                    decoration: BoxDecoration(
                                                      color: HinosaTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x33000000),
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController4,
                                                      focusNode: _model
                                                          .textFieldFocusNode4,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Suffix',
                                                        labelStyle: HinosaTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xA717171F),
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                        hintStyle: HinosaTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 11.0,
                                                            ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .primary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xFFECECEC),
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    5.0,
                                                                    10.0,
                                                                    5.0),
                                                      ),
                                                      style: HinosaTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF17171F),
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                      validator: _model
                                                          .textController4Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                -1.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                'Birth Date:',
                                                style: HinosaTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF17171F),
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 356.0,
                                            height: 35.0,
                                            decoration: BoxDecoration(
                                              color: HinosaTheme.of(context)
                                                  .secondaryBackground,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(0.0, 2.0),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: TextFormField(
                                              controller:
                                                  _model.textController5,
                                              focusNode:
                                                  _model.textFieldFocusNode5,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                    HinosaTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 13.0,
                                                        ),
                                                hintStyle:
                                                    HinosaTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 13.0,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                        HinosaTheme.of(context)
                                                            .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF191645),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                        HinosaTheme.of(context)
                                                            .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                        HinosaTheme.of(context)
                                                            .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                filled: true,
                                                fillColor: Color(0xFFECECEC),
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(10.0, 5.0,
                                                            10.0, 5.0),
                                                suffixIcon: Icon(
                                                  Icons.calendar_month,
                                                  color: Color(0xFF6BDDC6),
                                                ),
                                              ),
                                              style: HinosaTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF17171F),
                                                    fontSize: 13.0,
                                                  ),
                                              validator: _model
                                                  .textController5Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                -1.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                'Vitals:',
                                                style: HinosaTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF17171F),
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 175.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: HinosaTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4.0,
                                                        color:
                                                            Color(0x33000000),
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: HinosaDropDown<String>(
                                                    controller: _model
                                                            .dropDownValueController ??=
                                                        FormFieldController<
                                                            String>(null),
                                                    options: ['Male', 'Female'],
                                                    onChanged: (val) =>
                                                        setState(() => _model
                                                                .dropDownValue =
                                                            val),
                                                    width: 300.0,
                                                    height: 50.0,
                                                    textStyle: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                    hintText: 'Sex',
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color: Color(0xFF6BDDC6),
                                                      size: 24.0,
                                                    ),
                                                    fillColor:
                                                        Color(0xFFECECEC),
                                                    elevation: 2.0,
                                                    borderColor:
                                                        HinosaTheme.of(context)
                                                            .alternate,
                                                    borderWidth: 2.0,
                                                    borderRadius: 5.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                5.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: false,
                                                    isMultiSelect: false,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          6.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 175.0,
                                                    height: 30.0,
                                                    decoration: BoxDecoration(
                                                      color: HinosaTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x33000000),
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController6,
                                                      focusNode: _model
                                                          .textFieldFocusNode6,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Age',
                                                        labelStyle: HinosaTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xA717171F),
                                                              fontSize: 13.0,
                                                            ),
                                                        hintStyle: HinosaTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 13.0,
                                                            ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFF191645),
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xFFECECEC),
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    5.0,
                                                                    15.0,
                                                                    5.0),
                                                      ),
                                                      style: HinosaTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF17171F),
                                                            fontSize: 13.0,
                                                          ),
                                                      validator: _model
                                                          .textController6Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 15.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 175.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: HinosaTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4.0,
                                                        color:
                                                            Color(0x33000000),
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController7,
                                                    focusNode: _model
                                                        .textFieldFocusNode7,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Height (cm)',
                                                      labelStyle:
                                                          HinosaTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Color(
                                                                    0xA717171F),
                                                                fontSize: 13.0,
                                                              ),
                                                      hintStyle: HinosaTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 13.0,
                                                          ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: HinosaTheme.of(
                                                                  context)
                                                              .alternate,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF191645),
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: HinosaTheme.of(
                                                                  context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: HinosaTheme.of(
                                                                  context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xFFECECEC),
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  5.0,
                                                                  10.0,
                                                                  5.0),
                                                    ),
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xA717171F),
                                                          fontSize: 13.0,
                                                        ),
                                                    validator: _model
                                                        .textController7Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          6.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 175.0,
                                                    height: 30.0,
                                                    decoration: BoxDecoration(
                                                      color: HinosaTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x33000000),
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController8,
                                                      focusNode: _model
                                                          .textFieldFocusNode8,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Weight (kg)',
                                                        labelStyle: HinosaTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xA717171F),
                                                              fontSize: 13.0,
                                                            ),
                                                        hintStyle: HinosaTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 13.0,
                                                            ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFF191645),
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                HinosaTheme.of(
                                                                        context)
                                                                    .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xFFECECEC),
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    5.0,
                                                                    10.0,
                                                                    5.0),
                                                      ),
                                                      style: HinosaTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF17171F),
                                                            fontSize: 13.0,
                                                          ),
                                                      validator: _model
                                                          .textController8Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 20.0, 0.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () {
                                                print('Button pressed ...');
                                              },
                                              text: 'Add Patient',
                                              options: FFButtonOptions(
                                                width: 352.0,
                                                height: 35.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color: Color(0xFF6BDDC6),
                                                textStyle: HinosaTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF17171F),
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                elevation: 3.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          32.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width: 771.0,
                                        height: 370.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF191645),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 12.0,
                                              color: Color(0x33000000),
                                              offset: Offset(0.0, 5.0),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      29.0, 24.0, 0.0, 0.0),
                                              child: Text(
                                                'Total Number of \nAppointments',
                                                style: HinosaTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFFDFCFD),
                                                      fontSize: 24.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.00, 0.00),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/Patient_Page.png',
                                                  width: 500.0,
                                                  height: 400.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.65, 0.00),
                                              child: Text(
                                                '768',
                                                style: HinosaTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFFDFCFD),
                                                      fontSize: 100.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    120.0, 60.0, 0.0, 60.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 488.0,
                                      height: 680.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 12.0,
                                            color: Color(0x33000000),
                                            offset: Offset(0.0, 5.0),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                          color: Color(0xFF191645),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 20.0, 0.0, 0.0),
                                                child: Text(
                                                  'Patient List ',
                                                  style: HinosaTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF17171F),
                                                        fontSize: 24.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 15.0, 0.0, 0.0),
                                            child: Container(
                                              width: 450.0,
                                              height: 595.0,
                                              decoration: BoxDecoration(
                                                color: HinosaTheme.of(context)
                                                    .secondaryBackground,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(15.0),
                                                  bottomRight:
                                                      Radius.circular(15.0),
                                                  topLeft: Radius.circular(0.0),
                                                  topRight:
                                                      Radius.circular(0.0),
                                                ),
                                                border: Border.all(
                                                  color: Color(0xFF191645),
                                                ),
                                              ),
                                              child: Builder(
                                                builder: (context) {
                                                  return FutureBuilder<
                                                      List<
                                                          Map<String,
                                                              dynamic>>>(
                                                    future: fetchPatients(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Center(
                                                            child: Text(
                                                                'Error: ${snapshot.error}'));
                                                      } else if (snapshot
                                                                  .data ==
                                                              null ||
                                                          snapshot
                                                              .data!.isEmpty) {
                                                        return Center(
                                                            child: Text(
                                                                'No data available.'));
                                                      } else {
                                                        final patientList =
                                                            snapshot.data!;
                                                        final filteredPatients =
                                                            patientList.where(
                                                                (patient) {
                                                          final fullName =
                                                              '${patient['patientFName']} ${patient['patientLName']}';
                                                          return fullName
                                                              .toLowerCase()
                                                              .contains(_model
                                                                  .textController9
                                                                  .text
                                                                  .toLowerCase());
                                                        }).toList();
                                                        return DataTable2(
                                                          columns: [
                                                            DataColumn2(
                                                              label:
                                                                  DefaultTextStyle
                                                                      .merge(
                                                                softWrap: true,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.00,
                                                                          0.00),
                                                                  child: Text(
                                                                    'Patient ID',
                                                                    style: HinosaTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFFFDFCFD),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              fixedWidth: 130.0,
                                                            ),
                                                            DataColumn2(
                                                              label:
                                                                  DefaultTextStyle
                                                                      .merge(
                                                                softWrap: true,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.00,
                                                                          0.00),
                                                                  child: Text(
                                                                    'Patient Name',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: HinosaTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFFFDFCFD),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              fixedWidth: 180.0,
                                                            ),
                                                            DataColumn2(
                                                              label:
                                                                  DefaultTextStyle
                                                                      .merge(
                                                                softWrap: true,
                                                                child: Opacity(
                                                                  opacity: 0.0,
                                                                  child:
                                                                      Container(),
                                                                ),
                                                              ),
                                                              fixedWidth: 85.0,
                                                            ),
                                                          ],
                                                          rows: filteredPatients
                                                              .map(
                                                                  (patient) =>
                                                                      DataRow(
                                                                        cells: [
                                                                          DataCell(
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.00, 0.00),
                                                                              child: Text(
                                                                                '${patient['_id']}',
                                                                                style: HinosaTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      color: Color(0xFF17171F),
                                                                                      fontSize: 13.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.00, 0.00),
                                                                              child: Text(
                                                                                '${patient['patientFName']} ${patient['patientLName']}',
                                                                                style: HinosaTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      color: Color(0xFF17171F),
                                                                                      fontSize: 13.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            FFButtonWidget(
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  selectedPatient = patient;
                                                                                });
                                                                              },
                                                                              text: 'Display',
                                                                              icon: Icon(
                                                                                Icons.remove_red_eye,
                                                                                color: Color.fromARGB(255, 25, 31, 23),
                                                                                size: 20.0,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                height: 30.0,
                                                                                width: 100.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(34.0, 0.0, 34.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ))
                                                              .toList(),
                                                          headingRowColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                            Color(0xFF191645),
                                                          ),
                                                          headingRowHeight:
                                                              56.0,
                                                          dataRowColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                            Color(0xFFFDFCFD),
                                                          ),
                                                          dataRowHeight: 56.0,
                                                          border: TableBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                          ),
                                                          dividerThickness: 0.0,
                                                          showBottomBorder:
                                                              true,
                                                          minWidth: 49.0,
                                                        );
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          19.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width: 692.0,
                                        height: 680.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 12.0,
                                              color: Color(0x33000000),
                                              offset: Offset(0.0, 5.0),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          border: Border.all(
                                            color: Color(0xFF191645),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      25.0, 24.0, 0.0, 0.0),
                                              child: Text(
                                                'Patient Information',
                                                style: HinosaTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF17171F),
                                                      fontSize: 24.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          25.0, 5.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Patient Name:',
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 5.0, 0.0, 0.0),
                                                  child: Text(
                                                    selectedPatient != null
                                                        ? '${selectedPatient!['patientFName']} ${selectedPatient!['patientLName']}'
                                                        : '',
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          25.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Patient ID:',
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    selectedPatient != null
                                                        ? '${selectedPatient!['_id']}'
                                                        : '',
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          25.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Sex:',
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    selectedPatient != null
                                                        ? '${selectedPatient!['patientSex']}'
                                                        : '',
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          25.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Date of Birth:',
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    selectedPatient != null
                                                        ? '${formatDateTime(selectedPatient!['patientBirthDate'])}'
                                                        : '',
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  25.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        'Date File Added:',
                                                        style: HinosaTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF17171F),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'PatientDFA_Placeholder',
                                                    style: HinosaTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF17171F),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      25.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                'Appointment History',
                                                style: HinosaTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF17171F),
                                                      fontSize: 24.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      25.0, 10.0, 0.0, 0.0),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      22.0, 5.0, 0.0, 0.0),
                                              child: Container(
                                                width: 649.0,
                                                height: 475.0,
                                                decoration: BoxDecoration(
                                                  color: HinosaTheme.of(context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15.0),
                                                    bottomRight:
                                                        Radius.circular(15.0),
                                                    topLeft:
                                                        Radius.circular(0.0),
                                                    topRight:
                                                        Radius.circular(0.0),
                                                  ),
                                                  border: Border.all(
                                                    color: Color(0xFF191645),
                                                  ),
                                                ),
                                                child:
                                                    selectedPatient?['_id'] ==
                                                            null
                                                        ? Center(
                                                            child: Text(
                                                                'Please select a patient.'),
                                                          )
                                                        : FutureBuilder<
                                                            List<
                                                                Map<String,
                                                                    dynamic>>>(
                                                            future: fetchAppointments(
                                                                selectedPatient![
                                                                    '_id']),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                ); // Show loading indicator while fetching
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                return Center(
                                                                  child: Text(
                                                                      'Error: ${snapshot.error}'),
                                                                );
                                                              } else if (snapshot
                                                                      .data ==
                                                                  null) {
                                                                return Center(
                                                                  child: Text(
                                                                      'Data is null'), // Handle the case where data is unexpectedly null
                                                                );
                                                              } else {
                                                                // Fetched data is available, update the appointmentHistory
                                                                List<
                                                                        Map<String,
                                                                            dynamic>>
                                                                    appointmentHistory =
                                                                    snapshot
                                                                        .data!;

                                                                // Return your DataTable2 with the fetched data
                                                                return DataTable2(
                                                                  columns: [
                                                                    DataColumn2(
                                                                      label: DefaultTextStyle
                                                                          .merge(
                                                                        softWrap:
                                                                            true,
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.00,
                                                                              0.00),
                                                                          child:
                                                                              Text(
                                                                            'Date',
                                                                            style: HinosaTheme.of(context).labelLarge.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  color: Color(0xFFFDFCFD),
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn2(
                                                                      label: DefaultTextStyle
                                                                          .merge(
                                                                        softWrap:
                                                                            true,
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.00,
                                                                              0.00),
                                                                          child:
                                                                              Text(
                                                                            'Reason',
                                                                            style: HinosaTheme.of(context).labelLarge.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  color: Color(0xFFFDFCFD),
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      fixedWidth:
                                                                          200.0,
                                                                    ),
                                                                    DataColumn2(
                                                                      label: DefaultTextStyle
                                                                          .merge(
                                                                        softWrap:
                                                                            true,
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.00,
                                                                              0.00),
                                                                          child:
                                                                              Text(
                                                                            'Records',
                                                                            style: HinosaTheme.of(context).labelLarge.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  color: Color(0xFFFDFCFD),
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  rows: appointmentHistory
                                                                      .asMap()
                                                                      .entries
                                                                      .map(
                                                                          (entry) {
                                                                    final appointmentHistoryIndex =
                                                                        entry
                                                                            .key;
                                                                    final appointmentHistoryItem =
                                                                        entry
                                                                            .value;
                                                                    return DataRow(
                                                                      cells: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.00,
                                                                              0.00),
                                                                          child:
                                                                              Text(
                                                                            // Use the actual appointment date from the item
                                                                            formatDateTime(appointmentHistoryItem['appointmentDate']),
                                                                            // appointmentHistoryItem['appointmentDate'],
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: HinosaTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  color: Color(0xFF17171F),
                                                                                  fontSize: 13.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.00,
                                                                              0.00),
                                                                          child:
                                                                              Text(
                                                                            // Use the actual appointment reason from the item
                                                                            appointmentHistoryItem['appointmentReason'].toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: HinosaTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  color: Color(0xFF17171F),
                                                                                  fontSize: 13.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        // Edit button
                                                                        IconButton(
                                                                          icon:
                                                                              Icon(Icons.edit),
                                                                          onPressed:
                                                                              () {
                                                                            showEditDialog(context,
                                                                                appointmentHistoryItem

                                                                                // Callback function to update the parent widget

                                                                                // Update the state in the parent widget as needed
                                                                                );
                                                                          },
                                                                        ),
                                                                      ]
                                                                          .map((c) =>
                                                                              DataCell(c))
                                                                          .toList(),
                                                                    );
                                                                  }).toList(),
                                                                  headingRowColor:
                                                                      MaterialStateProperty.all(
                                                                          Color(
                                                                              0xFF191645)),
                                                                  headingRowHeight:
                                                                      56.0,
                                                                  dataRowColor:
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .white),
                                                                  dataRowHeight:
                                                                      56.0,
                                                                  border:
                                                                      TableBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                  ),
                                                                  dividerThickness:
                                                                      0.0,
                                                                  showBottomBorder:
                                                                      true,
                                                                  minWidth:
                                                                      49.0,
                                                                );
                                                              }
                                                            },
                                                          ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 160.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFDFCFD), Color(0x00FFFFFF)],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(0.0, 1.0),
                              end: AlignmentDirectional(0, -1.0),
                            ),
                            border: Border.all(
                              color: Color(0x00FFFFFF),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              nav_bar(),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Opacity(
                                    opacity: 0.5,
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 25.0, 0.0, 10.0),
                                        child: Text(
                                          'Copyright 2023-2024 @ Farmacia Hinosa Inc. ',
                                          style: HinosaTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: Color(0xFF17171F),
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
