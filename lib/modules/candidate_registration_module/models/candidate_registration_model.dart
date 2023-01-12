class CandidateRegistrationModel {
  CandidateRegistrationModel({
    required this.email,
    required this.candidateName,
    required this.contactNumber,
    required this.canadianResidence,
    required this.yrOfExp,
    required this.province,
    required this.city,
    required this.canDrive,
    required this.haveCar,
    required this.dob,
    required this.qualification,
    required this.gender,
    required this.immigStatus,
    required this.industryIds,
    required this.preferredCityIds,
    required this.resumeExtension,
    required this.resumeName,
    required this.permittedToWork,
    required this.resume,
    required this.candidateExperiences,
  });

  String email;
  String candidateName;
  String contactNumber;
  bool canadianResidence;
  int yrOfExp;
  String province;
  String city;
  bool canDrive;
  bool haveCar;
  String dob;
  String qualification;
  String gender;
  String immigStatus;
  List<int> industryIds;
  List<int> preferredCityIds;
  String resumeExtension;
  String resumeName;
  bool permittedToWork;
  String resume;
  List<CandidateExperienceModel> candidateExperiences;

  factory CandidateRegistrationModel.fromJson(Map<String, dynamic> json) =>
      CandidateRegistrationModel(
        email: json["email"],
        candidateName: json["candidateName"],
        contactNumber: json["contactNumber"],
        canadianResidence: json["canadianResidence"],
        yrOfExp: json["yrOfExp"],
        province: json["province"],
        city: json["city"],
        canDrive: json["canDrive"],
        haveCar: json["haveCar"],
        dob: json["dob"],
        qualification: json["qualification"],
        gender: json["gender"],
        immigStatus: json["immigStatus"],
        industryIds: List<int>.from(json["industryIds"].map((x) => x)),
        preferredCityIds:
            List<int>.from(json["preferredCityIds"].map((x) => x)),
        resumeExtension: json["resumeExtension"],
        resumeName: json["resumeName"],
        permittedToWork: json["permittedToWork"],
        resume: json["resume"],
        candidateExperiences: List<CandidateExperienceModel>.from(
            json["candidateExperiences"]
                .map((x) => CandidateExperienceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "candidateName": candidateName,
        "contactNumber": contactNumber,
        "canadianResidence": canadianResidence,
        "yrOfExp": yrOfExp,
        "province": province,
        "city": city,
        "canDrive": canDrive,
        "haveCar": haveCar,
        "dob": dob,
        "qualification": qualification,
        "gender": gender,
        "immigStatus": immigStatus,
        "industryIds": List<dynamic>.from(industryIds.map((x) => x)),
        "preferredCityIds": List<dynamic>.from(preferredCityIds.map((x) => x)),
        "resumeExtension": resumeExtension,
        "resumeName": resumeName,
        "permittedToWork": permittedToWork,
        "resume": resume,
        "candidateExperiences":
            List<dynamic>.from(candidateExperiences.map((x) => x.toJson())),
      };
}

class CandidateExperienceModel {
  CandidateExperienceModel({
    required this.companyName,
    required this.designation,
    required this.workedInCanada,
    required this.province,
    required this.city,
    required this.startYear,
    required this.endYear,
  });

  String companyName;
  String designation;
  bool workedInCanada;
  String province;
  String city;
  String startYear;
  String endYear;

  factory CandidateExperienceModel.fromJson(Map<String, dynamic> json) =>
      CandidateExperienceModel(
        companyName: json["companyName"],
        designation: json["designation"],
        workedInCanada: json["workedInCanada"],
        province: json["province"],
        city: json["city"],
        startYear: json["startYear"],
        endYear: json["endYear"],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "designation": designation,
        "workedInCanada": workedInCanada,
        "province": province,
        "city": city,
        "startYear": startYear,
        "endYear": endYear,
      };
}
