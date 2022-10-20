class Products {
  late String productId;
  late String productImage;
  late String productName;
  late String productCategory;
  late int productPrice;
  late String productDescription;
  late String minimum;
  late String rate;

  Products.fromData({required Map<String, dynamic> data}) {
    productId = data['_id'];
    productImage = data['image'];
    productName = data['name'];
    productCategory = data['category'];
    productPrice = data['price'];
    productDescription = data['description'];
    minimum = data['minimum'];
    rate = data['rate'];
  }
}

// List products = [
//   {
//     'productId': '0',
//     'productImage': 'images/products/product1.png',
//     'productName': 'Office Plant',
//     'productPrice': 200,
//     'productCategory': 'decorative',
//     'productDescription':
//         'This is mango tree, I lke mango, mango is sweet, This is mango tree, I lke mango, mango is sweet This is mango tree, I lke mango, mango is sweet',
//   },
//   {
//     'productId': '1',
//     'productImage': 'images/products/product2.png',
//     'productName': 'Litchi Tree',
//     'productPrice': 150,
//     'productCategory': 'Fruit',
//     'productDescription':
//         'This is mango tree, I lke mango, mango is sweet, This is mango tree, I lke mango, mango is sweet This is mango tree, I lke mango, mango is sweet',
//   },
//   {
//     'productId': '2',
//     'productImage': 'images/products/product3.jpg',
//     'productName': 'Coconut Tree',
//     'productPrice': 300,
//     'productCategory': 'Fruit',
//     'productDescription':
//         'This is mango tree, I lke mango, mango is sweet, This is mango tree, I lke mango, mango is sweet This is mango tree, I lke mango, mango is sweet',
//   },
//   {
//     'productId': '3',
//     'productImage': 'images/products/product4.png',
//     'productName': 'Mango Tree',
//     'productPrice': 100,
//     'productCategory': 'Fruit',
//     'productDescription':
//         'This is mango tree, I lke mango, mango is sweet, This is mango tree This is mango tree, I lke mango, mango is sweet, This is mango tree, I lke mango, mango is sweet This is mango tree, I lke mango, mango is sweet',
//   },
//   {
//     'productId': '4',
//     'productImage': 'images/products/product5.png',
//     'productName': 'Lemon Tree',
//     'productPrice': 50,
//     'productCategory': 'Garden',
//     'productDescription':
//         'This is mango tree, I lke mango, mango is sweet, This is mango tree, I lke mango, mango is sweet This is mango tree, I lke mango, mango is sweet',
//   },
//   {
//     'productId': '5',
//     'productImage': 'images/products/product6.png',
//     'productName': 'Bonsai Tree',
//     'productPrice': 2000,
//     'productCategory': 'Bonsai',
//     'productDescription':
//         'This is mango tree, I lke mango, mango is sweet, This is mango tree, I lke mango, mango is sweet This is mango tree, I lke mango, mango is sweet',
//   },
//   {
//     'productId': '6',
//     'productImage': 'images/products/product7.png',
//     'productName': 'Cactus',
//     'productCategory': 'Cactus',
//     'productPrice': 600,
//     'productDescription':
//         'This is mango tree, I lke mango, mango is sweet, This is mango tree, I lke mango, mango is sweet This is mango tree, I lke mango, mango is sweet',
//   },
//   {
//     'productId': '7',
//     'productImage': 'images/products/product8.png',
//     'productName': 'Decorative Plant',
//     'productPrice': 1000,
//     'productCategory': 'decorative',
//     'productDescription':
//         'This is mango tree, I lke mango, mango is sweet, This is mango tree, I lke mango, mango is sweet This is mango tree, I lke mango, mango is sweet',
//   },
// ];
