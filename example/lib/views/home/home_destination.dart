enum HomeDestination {
  addressButtons('/buttons/address'),
  squareButtons('/buttons/square'),
  checkoutTileContainer('/containers/checkout'),
  cartItemTile('/tiles/cart-item');

  const HomeDestination(this.path);

  final String path;

  static HomeDestination fromPath(String path) {
    return switch (path) {
      '/buttons/square' => squareButtons,
      '/buttons/address' => addressButtons,
      '/containers/checkout' => checkoutTileContainer,
      '/tiles/cart-item' => cartItemTile,
      _ => throw ArgumentError.value(
          path,
          'path',
          'Unsupported home destination',
        ),
    };
  }
}
