require 'test_helper'

class DataUpdaterTest < ActiveSupport::TestCase
  test "parse_response returns correct hash structure" do
    response = { :get_currencies_response => { :get_currencies_result => "<NewDataSet>\n  <Table>\n    <Name>Afghanistan, Islamic State of</Name>\n    <CountryCode>af</CountryCode>\n    <Currency>Afghani</Currency>\n    <CurrencyCode>AFA</CurrencyCode>\n  </Table>\n  </NewDataSet>" } }
    expected = {
      :countries  => [{ :name => "Afghanistan, Islamic State of", :code => "af"   }],
      :currencies => [{ :name => "Afghani", :code => "AFA", :country_id => "af" }]
    }

    DataUpdater.send(:public, :parse_response)
    
    assert expected, DataUpdater.instance.parse_response(response)
  end
end