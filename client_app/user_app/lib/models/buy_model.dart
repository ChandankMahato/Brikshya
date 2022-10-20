class Listing {
  late String id;
  late String image;
  late String name;
  late String minimum;
  late String rate;

  Listing.fromData({required Map<String, dynamic> data}) {
    id = data['_id'];
    image = data['image'];
    name = data['name'];
    minimum = data['minimum'];
    rate = data['rate'];
  }
}

List buyList = [
  {
    '_id': '0',
    'image': 'images/product1.png',
    'name': 'Tractor Service',
    'rate': 'Rs 1500/hr',
    'minimum': '1day'
  },
  {
    '_id': '0',
    'image': 'images/product2.png',
    'name': 'Clay Pot(small)',
    'rate': 'Rs 50/peice',
    'minimum': '50 Peice'
  },
  {
    '_id': '0',
    'image': 'images/product3.jpg',
    'name': 'Mango Seeds',
    'rate': 'Rs 200/bucket',
    'minimum': '1 bucket'
  },
  {
    '_id': '0',
    'image': 'images/product4.png',
    'name': 'Litchi Tree(big)',
    'rate': 'Rs 5/graft',
    'minimum': '1 tree'
  },
  {
    '_id': '0',
    'image': 'images/product5.png',
    'name': 'Mango Panicle',
    'rate': 'Rs 1/panicle',
    'minimum': '500 Panicle'
  },
];
