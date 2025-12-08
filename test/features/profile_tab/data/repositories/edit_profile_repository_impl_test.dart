import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/profile_tab/data/data_sources/edit_profile_data_source.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_request.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_response/edit_profile_response.dart';
import 'package:exam_app/features/profile_tab/data/repositories/edit_profile_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'edit_profile_repository_impl_test.mocks.dart';

@GenerateMocks([EditProfileDataSource])
void main() {
  late EditProfileRepositoryImpl repository;
  late MockEditProfileDataSource mockdataSource;

  setUp(() {
    mockdataSource = MockEditProfileDataSource();
    repository = EditProfileRepositoryImpl(mockdataSource);

    provideDummy<BaseResponse<EditProfileResponse>>(
      SuccessResponse(data: EditProfileResponse(message: 'dummy')),
    );
  });

  group('Edit profile repository cases', () {
    test(
      'success case : should return SuccessResponse<EditProfileResponse>',
      () async {
        //arrange

        final request = EditProfileRequest(
          firstName: "Omar",
          lastName: "Ali",
          phone: "01123456",
          email: "omar@test.com",
        );

        final dummyResponse = EditProfileResponse(message: 'profile Updated');

        when(mockdataSource.editProfile(request)).thenAnswer(
          (_) async =>
              SuccessResponse<EditProfileResponse>(data: dummyResponse),
        );

        //Act
        final result =await repository.editProfile(request);
        expect(result, isA<SuccessResponse<EditProfileResponse>>());
        expect(
          (result as SuccessResponse<EditProfileResponse>).data.message,
          ('profile Updated'),
        );
        verify(mockdataSource.editProfile(request)).called(1);
      },
    );
  });
}
