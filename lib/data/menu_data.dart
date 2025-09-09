class MenuItem {
  final String id;
  final String name;
  final int price; 
  final String? imageAsset;

  const MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.imageAsset,
  });
}

class MenuData {
  static final items = <MenuItem>[
    const MenuItem(id: 'm1', name: 'Nasi Goreng Ayam', price: 35000, imageAsset: 'assets/image/nasigoreng-2.jpg'),
    const MenuItem(id: 'm2', name: 'Nasi Goreng Seafood', price: 28000, imageAsset: 'assets/image/nasigoreng.jpg'),
    const MenuItem(id: 'm3', name: 'Mie Goreng Spesial', price: 22000, imageAsset: 'assets/image/miegoreng.jpg'),
    const MenuItem(id: 'm4', name: 'Bakso', price: 18000, imageAsset: 'assets/image/bakso.jpg'),
    const MenuItem(id: 'm5', name: 'Es Teh', price: 5000, imageAsset: 'assets/image/esteh.jpg'),
  ];
}
