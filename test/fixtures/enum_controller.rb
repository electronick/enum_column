class EnumController < ActionController::Base
  layout false

  def enum_select
    @test = Enumeration.new
    render :inline => "<%= enum_select('test', 'severity')%>"
  end

end
