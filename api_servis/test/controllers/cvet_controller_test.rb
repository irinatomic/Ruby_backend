# test/controllers/cvet_controller_test.rb

require 'test_helper'

class CvetControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cvet = Cvet.create(naziv: 'Test Flower 1')
  end

  test "should get index" do
    get cvet_index_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal 1, json_response.length
    assert_equal @cvet.naziv, json_response[0]['naziv']
  end

  test "should show cvet" do
    get cvet_url(@cvet)
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @cvet.naziv, json_response['naziv']
  end

  test "should create cvet" do
    assert_difference('Cvet.count') do
      post cvet_index_url, params: { cvet: { naziv: 'New Flower' } }
    end

    assert_response :created

    json_response = JSON.parse(response.body)
    assert_equal 'New Flower', json_response['naziv']
  end

  test "should update cvet" do
    patch cvet_url(@cvet), params: { cvet: { naziv: 'Updated Flower' } }
    assert_response :success

    @cvet.reload
    assert_equal 'Updated Flower', @cvet.naziv
  end

  test "should destroy cvet" do
    assert_difference('Cvet.count', -1) do
      delete cvet_url(@cvet)
    end

    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @cvet.id, json_response['id']
  end

  test "should handle record not found in show" do
    get cvet_url(id: 'nonexistent_id')
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal 'Record not found', json_response['error']
  end

  test "should handle record not found in update" do
    patch cvet_url(id: 'nonexistent_id'), params: { cvet: { naziv: 'Updated Flower' } }
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal 'Record not found', json_response['error']
  end

  test "should handle record not found in destroy" do
    delete cvet_url(id: 'nonexistent_id')
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal 'Record not found', json_response['error']
  end

end
