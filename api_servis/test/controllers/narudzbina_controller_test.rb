# test/controllers/narudzbina_controller_test.rb

require 'test_helper'

class NarudzbinaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kategorija = Kategorija.create!(naziv: 'Buket')

    @proizvod1 = Proizvod.create!(naziv: 'Proizvod 1', opis: 'Opis 1', cena: 1200, kategorija_id: @kategorija.id)
    @proizvod2 = Proizvod.create!(naziv: 'Proizvod 2', opis: 'Opis 2', cena: 1500, kategorija_id: @kategorija.id)

    @korisnik = Korisnik.create!(username: 'username', password: 'password', admin: false, email: 'email@test.com')

    @narudzbina = Narudzbina.create!(zakazano_vreme: "2023-10-05T18:30:00.000Z",
      adresa: 'Adresa test',
      telefon: '0641234567',
      email: 'email@test.com',
      ime_prezime: 'ime prezime test',
      status_narudzbine: 'Nova',
      korisnik_id: @korisnik.id
    )

    @stavkanarudzbine = StavkaNarudzbine.create!(
      narudzbina_id: @narudzbina.id,
      proizvod_id: @proizvod1.id,
      jedinicna_cena: @proizvod1.cena,
      kolicina: 2
    )

    # auth admin
    @admin = Korisnik.find_by(id: 1)
    @admin&.update(admin: true) || @admin = Korisnik.create!(id: 1, username: 'admin', password_digest: 'admin', admin: true, email: 'admin@email.com')
    @headers_admin = { 
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.7GHFm9JNJ5ux50fhAThTM9Jjzz-DXLNneK7XyWh73Ng'
    }
  
    @user = Korisnik.create!(id: 4, username: 'username_four', password_digest: BCrypt::Password.create('password'), admin: false, 'email': 'username_four@example.com')
    @headers_user = { 
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0fQ.DmuC_7foBCktryYM5_w2uUTsKogre00n6Cdqymikkfo'
    }
  end

  test "should get index" do
    get narudzbina_index_url, headers: @headers_admin, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal 1, json_response.length
    assert_narudzbina_response(json_response[0], @narudzbina)
  end

  test "should show narudzbina" do
    get narudzbina_url(@narudzbina), headers: @headers_admin, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)    # object
    assert_equal 9, json_response.length
    assert_narudzbina_response(json_response, @narudzbina)
  end

  # helper method
  def assert_narudzbina_response(json_response_object, narudzbina)
    assert_equal narudzbina.email, json_response_object['email']
    assert_equal narudzbina.adresa, json_response_object['adresa']
    assert_equal narudzbina.telefon, json_response_object['telefon']
    assert_equal narudzbina.ime_prezime, json_response_object['ime_prezime']
    assert_equal narudzbina.korisnik_id, json_response_object['korisnik_id']
    assert_equal narudzbina.zakazano_vreme, json_response_object['zakazano_vreme']
    assert_equal narudzbina.status_narudzbine, json_response_object['status_narudzbine']
  end

  test "should create narudzbina" do
    narudzbina_params = {
      zakazano_vreme: "2023-10-05T18:30:00.000Z",
      adresa: "Kralja Milana 25/2",
      telefon: "0641234567",
      email: "ime_prezime@email.com",
      ime_prezime: "ime_prezime",
      korisnik_id: @korisnik.id,
      sadrzaj: {
        "#{@proizvod1.id}": "3",
        "#{@proizvod2.id}": "4"
      }
    }

    assert_difference('Narudzbina.count', 1) do
      post narudzbina_index_url,
      headers: @headers_user,
      params: narudzbina_params,
      as: :json
    end

    # Narudzbina
    assert_response :success
    created_narudzbina = Narudzbina.last

    # StavkaNarudzbine
    assert_equal 2, created_narudzbina.stavke_narudzbine.count
    created_narudzbina.stavke_narudzbine.each do |stavka|
      assert_equal created_narudzbina.id, stavka.narudzbina_id
    end
  end

  test "should update narudzbina" do
    narudzbina_params = {
      zakazano_vreme: "2023-10-05T18:30:00.000Z",
      adresa: "Adresa nova",
      telefon: "0641234567",
      email: "ime_prezime_novo@email.com",
      ime_prezime: "ime prezime test",
      sadrzaj: {
        "#{@proizvod2.id}": "4",
      }
    }

    put narudzbina_url(@narudzbina), 
    headers: @headers_user,
    params: narudzbina_params, 
    as: :json

    assert_response :success
    @narudzbina.reload

    # Narudzbina
    assert_equal "Adresa nova", @narudzbina.adresa
    assert_equal "ime_prezime_novo@email.com", @narudzbina.email

    # StavkaNarudzbine 
    assert_equal 1, @narudzbina.stavke_narudzbine.count
    assert_equal 4, @narudzbina.stavke_narudzbine.find_by(proizvod_id: @proizvod2.id).kolicina
  end

  test "should destroy narudzbina" do
    assert_difference('Narudzbina.count', -1) do
      assert_difference('StavkaNarudzbine.count', -1 * @narudzbina.stavke_narudzbine.count) do
        delete narudzbina_url(@narudzbina), headers: @headers_admin, as: :json
      end
    end
  
    assert_response :success
    assert_raises(ActiveRecord::RecordNotFound) { @narudzbina.reload }
    @narudzbina.stavke_narudzbine.each do |stavka|
      assert_raises(ActiveRecord::RecordNotFound) { stavka.reload }
    end
  end

  test "should change status for narudzbina" do
    put promeni_status_url(@narudzbina), 
    headers: @headers_admin,
    params: { "status_narudzbine": "Odbijeno" }, 
    as: :json

    assert_response :success
    @narudzbina.reload
    assert_equal "Odbijeno", @narudzbina.status_narudzbine
  end

end