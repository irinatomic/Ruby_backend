# test/controllers/proizvod_controller_test.rb

require 'test_helper'

class ProizvodControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kategorija = Kategorija.create!(naziv: 'Buket')

    @astromerija = Cvet.create!(naziv: 'Astromerija')
    @ruza = Cvet.create(naziv: 'Ruza')
    @lala = Cvet.create(naziv: 'Lala')

    @proizvod = Proizvod.create!(naziv: 'Midnight boquet',
      opis: 'Midnight buket stvara tramnu i misterioznu atmosferu - 10 astromerija',
      cena: 1200,
      kategorija_id: 1
    )

    @cvetuproizvodu = CvetUProizvodu.create!(cvet_id: @astromerija.id,
      proizvod_id: @proizvod.id,
      kolicina: 10
    )
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
    assert_difference('Proizvod.count') do
      post proizvod_index_url, params: {
        naziv: "Testni",
        opis: "Opis test",
        kategorija: "1",
        cena: "500",
        sadrzaj: {
          "#{@astromerija.id}": "5",
          "#{@ruza.id}": "4",
          "#{@lala.id}": "3"
        }
      }, as: :json
    end

    assert_response :created
    created_proizvod = Proizvod.last
    assert_equal 3, created_proizvod.cvetovi_u_proizvodu.count

    created_proizvod.cvetovi_u_proizvodu.each do |cvet_u_proizvodu|
      assert_equal created_proizvod.id, cvet_u_proizvodu.proizvod_id
    end
  end

  test "should update proizvod" do
    put proizvod_url(@proizvod), params: {
      naziv: "Testni",
      opis: "Opis test - izmena",
      kategorija: "1",
      cena: "500",
      sadrzaj: {
        "#{@astromerija.id}": "3"
      }
    }, as: :json
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
        delete proizvod_url(@proizvod)
      end
    end
  
    assert_response :success
    assert_raises(ActiveRecord::RecordNotFound) { @proizvod.reload }
    @proizvod.cvetovi_u_proizvodu.each do |cvet_u_proizvodu|
      assert_raises(ActiveRecord::RecordNotFound) { cvet_u_proizvodu.reload }
    end
  end

  test "should change cena for proizvod" do
    put promeni_cenu_url(@proizvod), params: {
      cena: "600"
    }, as: :json
    assert_response :success
    @proizvod.reload
    assert_equal 600, @proizvod.cena
  end

end