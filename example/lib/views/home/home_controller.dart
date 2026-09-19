import 'package:example/views/home/home_coordinator.dart';
import 'package:example/views/home/home_view_model.dart';

class HomeController {

  HomeController({
    required this.coordinator,
    required this.viewModel,
  });

  final HomeCoordinator coordinator;
  final HomeViewModel viewModel;
}