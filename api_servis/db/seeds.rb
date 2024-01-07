# require 'bcrypt'
# password: BCrypt::Password.create('password')

# USERS
seedDataUsers = [
  {
    username: 'admin',
    password:'admin',
    admin: true,
    email: 'admin@example.com',
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    username: 'username_one',
    password: 'password',
    admin: false,
    email: 'username_one@example.com',
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    username: 'username_two',
    password: 'password',
    admin: false,
    email: 'username_two@example.com',
    created_at: Time.current,
    updated_at: Time.current
  },
]

User.create(seedDataUsers)

# CATEGORIES
seedDataCategories = [
  {
    name: 'Buket',
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    name: 'Aranžman',
    created_at: Time.current,
    updated_at: Time.current
  }
]

Category.create(seedDataCategories)

# FLOWERS
seedDataFlowers = [
  { 
    name: 'Crvene ruže',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    name: 'Roze ruže',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    name: 'Žute ruže',
    created_at: Time.current,
    updated_at: Time.current
    },
  { 
    name: 'Orhideje',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    name: 'Karanfili',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    name: 'Ljiljani',
    created_at: Time.current,
    updated_at: Time.current
    },
  { 
    name: 'Astromerija',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    name: 'Narcisi',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    name: 'Lale',
    created_at: Time.current,
    updated_at: Time.current
    },
  { 
    name: 'Frezije',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    name: 'Zumbuli',
    created_at: Time.current,
    updated_at: Time.current
    }
]

Flower.create(seedDataFlowers)

# PRODUCTS
seedDataProducts = [
  {
    name: 'Midnight boquet',
    description: 'Midnight buket stvara tramnu i misterioznu atmosferu - 10 astromerija',
    price: 1200,
    category_id: 1,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    name: 'I love you',
    description: 'Savršen poklon za voljenu osobu (12 crvenih ruža)',
    price: 1440,
    category_id: 1,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    name: 'Warm summer day',
    description: 'Kada želite da osunčate Vaš dom (6 karanfila, 2 astromerije i 2 ljiljana).',
    price: 1800,
    category_id: 1,
    created_at: Time.current,
    updated_at: Time.current
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
    user_id: 2,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    scheduled_time: '2023-10-06 12:00:00',
    order_status: 'Prihvaćena',
    address: 'Knez Mihailova 6/6',
    phone: '0641234567',
    email: 'ime_prezime@example.com',
    full_name: 'ime_prezime',
    user_id: 2,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    scheduled_time: '2023-10-06 14:00:00',
    order_status: 'Prihvaćena',
    address: 'Milutina Milankovića 17',
    phone: '0641234567',
    email: 'ime_prezime@example.com',
    full_name: 'ime_prezime',
    user_id: 3,
    created_at: Time.current,
    updated_at: Time.current
  }
]

Order.create(seedDataOrders)

# ORDER_ITEMS
seedDataOrderItems = [
  {
    product_id: 2,
    order_id: 1,
    quantity: 1,
    unit_price: 1440,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    product_id: 3,
    order_id: 1,
    quantity: 1,
    unit_price: 1800,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    product_id: 1,
    order_id: 2,
    quantity: 1,
    unit_price: 1200,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    product_id: 2,
    order_id: 3,
    quantity: 1,
    unit_price: 1440,
    created_at: Time.current,
    updated_at: Time.current
  }
]

OrderItem.create(seedDataOrderItems)

# FLOWER_IN_PRODUCTS
seedDataFlowerInProducts = [
  {
    flower_id: 7,
    product_id: 1,
    quantity: 10,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    flower_id: 1,
    product_id: 2,
    quantity: 12,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    flower_id: 5,
    product_id: 3,
    quantity: 6,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    flower_id: 7,
    product_id: 3,
    quantity: 2,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    flower_id: 6,
    product_id: 3,
    quantity: 2,
    created_at: Time.current,
    updated_at: Time.current
  },
]

FlowerInProduct.create(seedDataFlowerInProducts)