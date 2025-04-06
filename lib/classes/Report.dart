class Report {
  String reportID;
  String fileURL;
  String date;
  String frequency;

  Report({
    required this.reportID,
    required this.fileURL,
    required this.date,
    required this.frequency,
  });

  Map<String, dynamic> toMap() {
    return {
      'reportID': reportID,
      'fileURL': fileURL,
      'date': date,
      'frequency': frequency,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      reportID: map['reportID'],
      fileURL: map['fileURL'],
      date: map['date'],
      frequency: map['frequency'],
    );
  }
}
