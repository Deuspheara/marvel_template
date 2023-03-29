import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/characters_response.dart';

part 'response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseDto {
  final CharacterResponse data;

  ResponseDto({
    required this.data,
  });

  factory ResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDtoToJson(this);
}
