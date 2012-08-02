require 'test_helper'

class CurrenciesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  should_not_respond_to_actions :new => :get, 
                                :destroy => :get, 
                                :create => :post,
                                :edit => :get, 
                                :update => :put

  setup do
    @currency = currencies(:one)
		sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:currencies)
  end

  test "should show currency" do
    get :show, :id => @currency.to_param
    assert_response :success
  end
end
