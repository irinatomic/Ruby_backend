# require 'bcrypt'
# password: BCrypt::Password.create('password')

# USERS
seedDataKorisnici = [
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

Korisnik.create(seedDataKorisnici)

# CATEGORIES
seedDataKategorije = [
  {
    naziv: 'Buket',
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    naziv: 'Aranžman',
    created_at: Time.current,
    updated_at: Time.current
  }
]

Kategorija.create(seedDataKategorije)

# FLOWERS
seedDataCvetovi = [
  { 
    naziv: 'Crvene ruže',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    naziv: 'Roze ruže',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    naziv: 'Žute ruže',
    created_at: Time.current,
    updated_at: Time.current
    },
  { 
    naziv: 'Orhideje',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    naziv: 'Karanfili',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    naziv: 'Ljiljani',
    created_at: Time.current,
    updated_at: Time.current
    },
  { 
    naziv: 'Astromerija',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    naziv: 'Narcisi',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    naziv: 'Lale',
    created_at: Time.current,
    updated_at: Time.current
    },
  { 
    naziv: 'Frezije',
    created_at: Time.current,
    updated_at: Time.current
    }, 
  { 
    naziv: 'Zumbuli',
    created_at: Time.current,
    updated_at: Time.current
    }
]

Cvet.create(seedDataCvetovi)

# PRODUCTS
seedDataProizvodi = [
  {
    naziv: 'Midnight boquet',
    opis: 'Midnight buket stvara tramnu i misterioznu atmosferu - 10 astromerija',
    cena: 1200,
    kategorija_id: 1,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    naziv: 'I love you',
    opis: 'Savršen poklon za voljenu osobu (12 crvenih ruža)',
    cena: 1440,
    kategorija_id: 1,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    naziv: 'Warm summer day',
    opis: 'Kada želite da osunčate Vaš dom (6 karanfila, 2 astromerije i 2 ljiljana).',
    cena: 1800,
    kategorija_id: 1,
    created_at: Time.current,
    updated_at: Time.current
  }
]

Proizvod.create(seedDataProizvodi)

# ORDERS
seedDataNarudzbine = [
  {
    zakazano_vreme: '2023-10-05 18:30:00',
    status_narudzbine: 'Nova',
    adresa: 'Kralja Milana 12/2',
    telefon: '0641234567',
    email: 'ime_prezime@example.com',
    ime_prezime: 'ime_prezime',
    korisnik_id: 2,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    zakazano_vreme: '2023-10-06 12:00:00',
    status_narudzbine: 'Prihvaćena',
    adresa: 'Knez Mihailova 6/6',
    telefon: '0641234567',
    email: 'ime_prezime@example.com',
    ime_prezime: 'ime_prezime',
    korisnik_id: 2,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    zakazano_vreme: '2023-10-06 14:00:00',
    status_narudzbine: 'Prihvaćena',
    adresa: 'Milutina Milankovića 17',
    telefon: '0641234567',
    email: 'ime_prezime@example.com',
    ime_prezime: 'ime_prezime',
    korisnik_id: 3,
    created_at: Time.current,
    updated_at: Time.current
  }
]

Narudzbina.create(seedDataNarudzbine)

# ORDER_ITEMS
seedDataStavkeNarudzbine = [
  {
    proizvod_id: 2,
    narudzbina_id: 1,
    kolicina: 1,
    jedinicna_cena: 1440,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    proizvod_id: 3,
    narudzbina_id: 1,
    kolicina: 1,
    jedinicna_cena: 1800,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    proizvod_id: 1,
    narudzbina_id: 2,
    kolicina: 1,
    jedinicna_cena: 1200,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    proizvod_id: 2,
    narudzbina_id: 3,
    kolicina: 1,
    jedinicna_cena: 1440,
    created_at: Time.current,
    updated_at: Time.current
  }
]

StavkaNarudzbine.create(seedDataStavkeNarudzbine)

# FLOWER_IN_PRODUCTS
seedDataCvetoviUProizvodima = [
  {
    cvet_id: 7,
    proizvod_id: 1,
    kolicina: 10,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    cvet_id: 1,
    proizvod_id: 2,
    kolicina: 12,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    cvet_id: 5,
    proizvod_id: 3,
    kolicina: 6,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    cvet_id: 7,
    proizvod_id: 3,
    kolicina: 2,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    cvet_id: 6,
    proizvod_id: 3,
    kolicina: 2,
    created_at: Time.current,
    updated_at: Time.current
  },
]

CvetUProizvodu.create(seedDataCvetoviUProizvodima)