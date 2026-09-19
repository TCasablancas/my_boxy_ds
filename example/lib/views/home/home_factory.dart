import 'package:flutter/material.dart';
import 'package:example/views/home/home_coordinator.dart';
import 'package:example/views/home/home_view_model.dart';
import 'package:example/views/home/home_controller.dart';
import 'package:example/views/home/home_view.dart';

class HomeFactory {

  static Widget make() {
    final coordinator = HomeCoordinator();
    final viewModel = HomeViewModel();

    final controller = HomeController(
      coordinator: coordinator,
      viewModel: viewModel,
    );

    return HomeView(controller: controller);
  }
}