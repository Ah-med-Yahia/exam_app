import 'package:json_annotation/json_annotation.dart';
part 'meta_data_dto.g.dart';
@JsonSerializable()
class MetadataDTO {
    @JsonKey(name: "currentPage")
    int? currentPage;
    @JsonKey(name: "numberOfPages")
    int? numberOfPages;
    @JsonKey(name: "limit")
    int? limit;

    MetadataDTO({
        this.currentPage,
        this.numberOfPages,
        this.limit,
    });

    factory MetadataDTO.fromJson(Map<String, dynamic> json) => _$MetadataDTOFromJson(json);

    Map<String, dynamic> toJson() => _$MetadataDTOToJson(this);
}