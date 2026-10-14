enum HomeDestination {
  addressButtons('/buttons/address'),
  squareButtons('/buttons/square'),
  cameraTest('/buttons/camera-test'),
  checkoutTileContainer('/containers/checkout'),
  cartItemTile('/tiles/cart-item'),
  onboardingCaroulsel('/carousels/onboarding'),
  allTags('/tags/all');

  const HomeDestination(this.path);

  final String path;

  static HomeDestination fromPath(String path) {
    return switch (path) {
      '/buttons/square' => squareButtons,
      '/buttons/address' => addressButtons,
      '/buttons/camera-test' => cameraTest,
      '/containers/checkout' => checkoutTileContainer,
      '/tiles/cart-item' => cartItemTile,
      '/carousels/onboarding' => onboardingCaroulsel,
      '/tags/all' => allTags,
      _ => throw ArgumentError.value(
          path,
          'path',
          'Unsupported home destination',
        ),
    };
  }
}
