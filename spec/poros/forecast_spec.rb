require 'rails_helper'

describe 'Forecast' do
  before :each do
    VCR.use_cassette('denverco_weather_request') do
      location = instance_double('Location', latitude: 39.738453, longitude: -104.984853)
      @data = WeatherService.weather_at_coords(location)
    end
  end

  it 'exists' do
    expect(Forecast.new(@data)).to be_a Forecast
  end

  before :each do
    @forecast = Forecast.new(@data)
  end
  it 'has attributes' do
    expect(@forecast.current_weather).to be_a Hash
    expect(@forecast.daily_weather).to be_an Array
    expect(@forecast.daily_weather.length).to eq(5)
    expect(@forecast.hourly_weather).to be_an Array
    expect(@forecast.hourly_weather.length).to eq(8)
  end

  it 'can format datetime' do
    seconds = 1610893087
    formatted_time = @forecast.format_datetime(seconds)

    expect(formatted_time).to eq(Time.at(seconds).to_s)
  end

  it 'has correctly formatted current_weather' do
    current_weather = @forecast.current_weather

    expect(current_weather).to have_key(:datetime)
    expect(current_weather[:datetime]).to eq(
      @forecast.format_datetime(@data[:current][:dt])
    )
    expect(current_weather).to have_key(:sunrise)
    expect(current_weather[:sunrise]).to eq(
      @forecast.format_datetime(@data[:current][:sunrise])
    )
    expect(current_weather).to have_key(:sunset)
    expect(current_weather[:sunset]).to eq(
      @forecast.format_datetime(@data[:current][:sunset])
    )
    expect(current_weather).to have_key(:temperature)
    expect(current_weather[:temperature]).to eq(@data[:current][:temp])
    expect(current_weather).to have_key(:feels_like)
    expect(current_weather[:feels_like]).to eq(@data[:current][:feels_like])
    expect(current_weather).to have_key(:humidity)
    expect(current_weather[:humidity]).to eq(@data[:current][:humidity])
    expect(current_weather).to have_key(:uvi)
    expect(current_weather[:uvi]).to eq(@data[:current][:uvi])
    expect(current_weather).to have_key(:visibility)
    expect(current_weather[:uvi]).to eq(@data[:current][:uvi])
    expect(current_weather).to have_key(:conditions)
    expect(current_weather[:conditions]).to eq(
      @data[:current][:weather][0][:description]
    )
    expect(current_weather).to have_key(:icon)
    expect(current_weather[:icon]).to eq(
      @data[:current][:weather][0][:icon]
    )
    expect(current_weather).to_not have_key(:dew_point)
    expect(current_weather).to_not have_key(:clouds)
    expect(current_weather).to_not have_key(:wind_speed)
    expect(current_weather).to_not have_key(:wind_gust)
    expect(current_weather).to_not have_key(:weather)
  end

  #test that daily_weather values are correctly formatted and do not include extraneous info
  #test that hourly_weather values are correctly formatted and do not include extraneous info
end
