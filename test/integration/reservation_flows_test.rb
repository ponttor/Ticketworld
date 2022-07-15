require "test_helper"

class ReservationFlowsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    @ticket = tickets(:one)
  end
  
  test 'should get api index' do
    get index_url
    # get index_url(format: :json)
    assert_response :success
  end
  
  # test 'should get api show' do
  #   get api_book_url(@book, format: :json)
  #   assert_response :success
  # end
end
