class GenericResponse {

  String? status;

  GenericResponse({
    required this.status,
  }); 
  
  factory GenericResponse.fromMap(Map<String, dynamic> json) {
    return GenericResponse(
      status: json['estado'],
    );
  }

}