import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/client_repository.dart';

class UploadClient implements UseCase<Client, UploadClientParams> {
  final ClientRepository clientRepository;
  UploadClient(this.clientRepository);
  @override
  Future<Either<Failure, Client>> call(UploadClientParams params) async {
    return await clientRepository.createClient(
      userId: params.userId,
      clientName: params.clientName,
      companyName: params.companyName,
      clientEmail: params.clientEmail,
    );
  }
}

class UploadClientParams {
  final String userId;
  final String clientName;
  final String companyName;
  final String clientEmail;

  UploadClientParams({
    required this.userId,
    required this.clientName,
    required this.companyName,
    required this.clientEmail,
  });
}
