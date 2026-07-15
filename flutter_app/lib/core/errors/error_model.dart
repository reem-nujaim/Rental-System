class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonDatd) {
    return ErrorModel(
      status: jsonDatd[''], //same name in api
      errorMessage: jsonDatd[''], //same name in api
    );
  }
}
