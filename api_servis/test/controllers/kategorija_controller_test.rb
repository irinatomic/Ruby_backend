# test/controllers/kategorija_controller_test.rb

require 'test_helper'

class KategorijaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kategorija = Kategorija.create(naziv: 'Test Category 1')
  end

  test "should get index" do
    get kategorija_index_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal 1, json_response.length
    assert_equal @kategorija.naziv, json_response[0]['naziv']
  end

  test "should show kategorija" do
    get kategorija_url(@kategorija)
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @kategorija.naziv, json_response['naziv']
  end

  test "should create kategorija" do
    assert_difference('Kategorija.count') do
      post kategorija_index_url, params: { kategorija: { naziv: 'New Category' } }
    end

    assert_response :created

    json_response = JSON.parse(response.body)
    assert_equal 'New Category', json_response['naziv']
  end

  test "should update kategorija" do
    patch kategorija_url(@kategorija), params: { kategorija: { naziv: 'Updated Category' } }
    assert_response :success

    @kategorija.reload
    assert_equal 'Updated Category', @kategorija.naziv
  end

  test "should destroy kategorija" do
    assert_difference('Kategorija.count', -1) do
      delete kategorija_url(@kategorija)
    end

    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @kategorija.id, json_response['id']
  end

  test "should handle record not found in show" do
    get kategorija_url(id: 'nonexistent_id')
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal 'Record not found', json_response['error']
  end

  test "should handle record not found in update" do
    patch kategorija_url(id: 'nonexistent_id'), params: { kategorija: { naziv: 'Updated Category' } }
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal 'Record not found', json_response['error']
  end

  test "should handle record not found in destroy" do
    delete kategorija_url(id: 'nonexistent_id')
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal 'Record not found', json_response['error']
  end

end
