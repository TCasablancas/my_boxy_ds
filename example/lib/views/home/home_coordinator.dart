import 'package:example/common/navigation_service.dart';
import 'package:flutter/widgets.dart';

import '../buttons/square_buttons.dart';
import '../containers/containers_view.dart';
import '../tiles/cart_item_tile_view.dart';
import 'home_destination.dart';
import '../buttons/address_button_view.dart';

class HomeCoordinator {
  final NavigationService _navigationService;

  HomeCoordinator({
    NavigationService? navigationService,
  }) : _navigationService = navigationService ?? NavigationService.instance;

  Future<void> navigate(String path) {
    final destination = HomeDestination.fromPath(path);
    return _navigationService.push<void>(
      switch (destination) {
        HomeDestination.squareButtons => const SquareButtons(),
        HomeDestination.addressButtons => const AddressButtonView(),
        HomeDestination.checkoutTileContainer => const CheckoutTileContainerView(),
        HomeDestination.cartItemTile => const CartItemTileView(),
      },
      settings: RouteSettings(name: destination.path),
    );
  }
}