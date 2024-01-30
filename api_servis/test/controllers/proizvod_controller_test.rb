# test/controllers/proizvod_controller_test.rb

require 'test_helper'
require 'bcrypt'

class ProizvodControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kategorija = Kategorija.create!(naziv: 'Buket')

    @astromerija = Cvet.create!(naziv: 'Astromerija')
    @ruza = Cvet.create(naziv: 'Ruza')
    @lala = Cvet.create(naziv: 'Lala')

    @proizvod = Proizvod.create!(naziv: 'Midnight boquet',
      opis: 'Midnight buket stvara tramnu i misterioznu atmosferu - 10 astromerija',
      cena: 1200,
      kategorija_id: @kategorija.id
    )

    @cvetuproizvodu = CvetUProizvodu.create!(cvet_id: @astromerija.id, proizvod_id: @proizvod.id, kolicina: 10)

    # auth
    @admin = Korisnik.find_by(id: 1)
    @admin&.update(admin: true) || @admin = Korisnik.create!(id: 1, username: 'admin', password_digest: 'admin', admin: true, email: 'admin@email.com')
    @headers_admin = { 
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.7GHFm9JNJ5ux50fhAThTM9Jjzz-DXLNneK7XyWh73Ng'
    }
  
    @user = Korisnik.create!(id: 4, username: 'username_four', password_digest: BCrypt::Password.create('password'), admin: false, 'email': 'username_four@example.com')
    @headers_user = { 'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0fQ.DmuC_7foBCktryYM5_w2uUTsKogre00n6Cdqymikkfo'}
  end

  test "should get index" do
    get proizvod_index_url
    assert_response :success
    
    json_response = JSON.parse(response.body)

    assert_equal 1, json_response.length
    assert_equal @proizvod.naziv, json_response[0]['naziv']
    assert_equal @proizvod.opis, json_response[0]['opis']
    assert_equal @proizvod.cena, json_response[0]['cena']
  end

  test "should show proizvod" do
    get proizvod_url(@proizvod)
    assert_response :success
    
    json_response = JSON.parse(response.body)
    assert_equal @proizvod.naziv, json_response['naziv']
    assert_equal @proizvod.opis, json_response['opis']
    assert_equal @proizvod.cena, json_response['cena']
  end

  test "should create proizvod" do
    puts @kategorija.id

    proizvod_params = {
      naziv: "Testni",
      opis: "Opis test",
      kategorija: @kategorija.id,
      cena: "500",
      sadrzaj: {
        "#{@astromerija.id}": "5",
        "#{@ruza.id}": "4",
        "#{@lala.id}": "3"
      }
    }

    assert_difference('Proizvod.count', 1) do
      post proizvod_index_url, 
      headers: @headers_admin,
      params: proizvod_params, 
      as: :json
    end

    # Proizvod
    assert_response :created
    created_proizvod = Proizvod.last

    # CvetUProizvodu
    assert_equal 3, created_proizvod.cvetovi_u_proizvodu.count
    created_proizvod.cvetovi_u_proizvodu.each do |cvet_u_proizvodu|
      assert_equal created_proizvod.id, cvet_u_proizvodu.proizvod_id
    end
  end

  test "should update proizvod" do
    proizvod_params = {
      naziv: "Testni",
      opis: "Opis test - izmena",
      kategorija: @kategorija.id,
      cena: "500",
      sadrzaj: {
        "#{@astromerija.id}": "3"
      }
    }

    put proizvod_url(@proizvod), 
    headers: @headers_admin, 
    params: proizvod_params, 
    as: :json

    assert_response :success
    @proizvod.reload

    # Proizvod
    assert_equal "Testni", @proizvod.naziv
    assert_equal "Opis test - izmena", @proizvod.opis
    assert_equal 500, @proizvod.cena

    # CvetUProizvodu
    assert_equal 1, @proizvod.cvetovi_u_proizvodu.count
    cvet_u_proizvodu = @proizvod.cvetovi_u_proizvodu.first
    assert_equal @astromerija.id, cvet_u_proizvodu.cvet_id
    assert_equal 3, cvet_u_proizvodu.kolicina
  end

  test "should destroy proizvod" do
    assert_difference('Proizvod.count', -1) do
      assert_difference('CvetUProizvodu.count', -1 * @proizvod.cvetovi_u_proizvodu.count) do
        delete proizvod_url(@proizvod), headers: @headers_admin, as: :json
      end
    end
  
    assert_response :success
    assert_raises(ActiveRecord::RecordNotFound) { @proizvod.reload }
    @proizvod.cvetovi_u_proizvodu.each do |cvet_u_proizvodu|
      assert_raises(ActiveRecord::RecordNotFound) { cvet_u_proizvodu.reload }
    end
  end

  test "should change cena for proizvod" do
    put promeni_cenu_url(@proizvod), 
    headers: @headers_admin,
    params: { cena: "600" }, 
    as: :json
    
    assert_response :success
    @proizvod.reload
    assert_equal 600, @proizvod.cena
  end

end