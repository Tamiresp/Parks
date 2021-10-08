class Parks {
  const Parks(this.image, this.name);

  final String image;
  final String name;
}

const List<Parks> parksList = const <Parks>[
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
];

const List<Parks> eventsList = const <Parks>[
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/parque.jpeg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
];

const List<Parks> favoritesList = const <Parks>[
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
  const Parks('images/sitio.jpg', "Sitio da Trindade"),
];

class FakeUser {
  const FakeUser(this.displayName, this.email, this.photoURL);
  final String displayName;
  final String email;
  final String photoURL;
}

const FakeUser getFakeUser = const FakeUser(
    'fake', 'fake@email.com', 'https://mapio.net/images-p/20246091.jpg');
