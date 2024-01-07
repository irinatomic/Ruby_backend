# require 'bcrypt'
# password: BCrypt::Password.create('password')

# USERS
seedDataUsers = [
  {
    username: 'admin',
    password:'admin',
    admin: true,
    email: 'admin@example.com'
  },
  {
    username: 'username_one',
    password: 'password',
    admin: false,
    email: 'username_one@example.com',
  },
  {
    username: 'username_two',
    password: 'password',
    admin: false,
    email: 'username_two@example.com',
  },
]

User.create(seedDataUsers)

# CATEGORIES
seedDataCategories = [
  {
    name: 'Buket'
  },
  {
    name: 'Aranžman'
  }
]

Category.create(seedDataCategories)

# FLOWERS
seedDataFlowers = [
  { name: 'Crvene ruže' }, 
  { name: 'Roze ruže' }, 
  { name: 'Žute ruže' },
  { name: 'Orhideje' }, 
  { name: 'Karanfili' }, 
  { name: 'Ljiljani' },
  { name: 'Astromerija' }, 
  { name: 'Narcisi' }, 
  { name: 'Lale' },
  { name: 'Frezije' }, 
  { name: 'Zumbuli' }
]

Flower.create(seedDataFlowers)

# PRODUCTS
seedDataProducts = [
  {
    name: 'Midnight boquet',
    description: 'Midnight buket stvara tramnu i misterioznu atmosferu - 10 astromerija',
    price: 1200,
    category_id: 1
  },
  {
    name: 'I love you',
    description: 'Savršen poklon za voljenu osobu (12 crvenih ruža)',
    price: 1440,
    category_id: 1
  },
  {
    name: 'Warm summer day',
    description: 'Kada želite da osunčate Vaš dom (6 karanfila, 2 astromerije i 2 ljiljana).',
    price: 1800,
    category_id: 1
  }
]

Product.create(seedDataProducts)

# ORDERS
seedDataOrders = [
  {
    scheduled_time: '2023-10-05 18:30:00',
    order_status: 'Nova',
    address: 'Kralja Milana 12/2',
    phone: '0641234567',
    email: 'ime_prezime@example.com',
    full_name: 'ime_prezime',
    user_id: 2
  },
  {
    scheduled_time: '2023-10-06 12:00:00',
    order_status: 'Prihvaćena',
    address: 'Knez Mihailova 6/6',
    phone: '0641234567',
    email: 'ime_prezime@example.com',
    full_name: 'ime_prezime',
    user_id: 2
  },
  {
    scheduled_time: '2023-10-06 14:00:00',
    order_status: 'Prihvaćena',
    address: 'Milutina Milankovića 17',
    phone: '0641234567',
    email: 'ime_prezime@example.com',
    full_name: 'ime_prezime',
    user_id: 3
  }
]

Order.create(seedDataOrders)

# ORDER_ITEMS
seedDataOrderItems = [
  {
    product_id: 2,
    order_id: 1,
    quantity: 1,
    unit_price: 1440
  },
  {
    product_id: 3,
    order_id: 1,
    quantity: 1,
    unit_price: 1800
  },
  {
    product_id: 1,
    order_id: 2,
    quantity: 1,
    unit_price: 1200
  },
  {
    product_id: 2,
    order_id: 3,
    quantity: 1,
    unit_price: 1440
  }
]

OrderItem.create(seedDataOrderItems)

# FLOWER_IN_PRODUCTS
seedDataFlowerInProducts = [
  {
    flower_id: 7,
    product_id: 1,
    quantity: 10
  },
  {
    flower_id: 1,
    product_id: 2,
    quantity: 12
  },
  {
    flower_id: 5,
    product_id: 3,
    quantity: 6
  },
  {
    flower_id: 7,
    product_id: 3,
    quantity: 2
  },
  {
    flower_id: 6,
    product_id: 3,
    quantity: 2
  },
]

FlowerInProduct.create(seedDataFlowerInProducts)