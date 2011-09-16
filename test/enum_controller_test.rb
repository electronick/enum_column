require File.dirname(__FILE__) + '/test_helper'
require 'fixtures/enumeration'
require 'fixtures/enum_controller'

class EnumControllerTest < ActionController::TestCase

  def setup
    Enumeration.connection.execute 'DELETE FROM enumerations'

    Rails.application.routes.draw do
      match '/enum_select' => "enum#enum_select"
    end
  end

  test "should render enum_select" do
    get :enum_select
    assert_response :success
    assert_equal '<select id="test_severity" name="test[severity]"><option value="low">low</option>
<option value="medium" selected="selected">medium</option>
<option value="high">high</option>
<option value="critical">critical</option></select>', @response.body
  end

end