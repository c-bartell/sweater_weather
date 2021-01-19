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
    expect(@forecast.id).to be nil
    expect(@forecast.current_weather).to be_a Hash
    expect(@forecast.daily_weather).to be_an Array
    expect(@forecast.daily_weather.length).to eq(5)
    expect(@forecast.hourly_weather).to be_an Array
    expect(@forecast.hourly_weather.length).to eq(8)
  end

  it 'can format datetime' do
    seconds = 1610893087
    formatted_time = @forecast.format_datetime(seconds)

    expect(formatted_time).to eq(Time.at(seconds).getlocal.to_s)
  end

  it 'can get compass direction from an angle' do
    expect(@forecast.cardinal_direction(0)).to eq 'N'
    expect(@forecast.cardinal_direction(11)).to eq 'N'
    expect(@forecast.cardinal_direction(22)).to eq 'N'
    expect(@forecast.cardinal_direction(23)).to eq 'NE'
    expect(@forecast.cardinal_direction(34)).to eq 'NE'
    expect(@forecast.cardinal_direction(67)).to eq 'NE'
    expect(@forecast.cardinal_direction(68)).to eq 'E'
    expect(@forecast.cardinal_direction(79)).to eq 'E'
    expect(@forecast.cardinal_direction(112)).to eq 'E'
    expect(@forecast.cardinal_direction(113)).to eq 'SE'
    expect(@forecast.cardinal_direction(124)).to eq 'SE'
    expect(@forecast.cardinal_direction(157)).to eq 'SE'
    expect(@forecast.cardinal_direction(158)).to eq 'S'
    expect(@forecast.cardinal_direction(169)).to eq 'S'
    expect(@forecast.cardinal_direction(202)).to eq 'S'
    expect(@forecast.cardinal_direction(203)).to eq 'SW'
    expect(@forecast.cardinal_direction(214)).to eq 'SW'
    expect(@forecast.cardinal_direction(247)).to eq 'SW'
    expect(@forecast.cardinal_direction(248)).to eq 'W'
    expect(@forecast.cardinal_direction(259)).to eq 'W'
    expect(@forecast.cardinal_direction(292)).to eq 'W'
    expect(@forecast.cardinal_direction(293)).to eq 'NW'
    expect(@forecast.cardinal_direction(304)).to eq 'NW'
    expect(@forecast.cardinal_direction(337)).to eq 'NW'
    expect(@forecast.cardinal_direction(338)).to eq 'N'
    expect(@forecast.cardinal_direction(349)).to eq 'N'
    expect(@forecast.cardinal_direction(359)).to eq 'N'
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
    expect(current_weather[:visibility]).to eq(@data[:current][:visibility])
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

  it 'has correctly formatted daily_weather' do
    daily_weather = @forecast.daily_weather[0]

    expect(daily_weather).to be_a Hash
    expect(daily_weather).to have_key :date
    expect(daily_weather[:date]).to eq(
      Time.at(@data[:daily][1][:dt]).getlocal.strftime("%Y-%m-%d")
    )
    expect(daily_weather).to have_key :sunrise
    expect(daily_weather[:sunrise]).to eq(
      Time.at(@data[:daily][1][:sunrise]).to_s
    )
    expect(daily_weather).to have_key :sunset
    expect(daily_weather[:sunset]).to eq(
      Time.at(@data[:daily][1][:sunset]).to_s
    )
    expect(daily_weather).to have_key :max_temp
    expect(daily_weather[:max_temp]).to eq @data[:daily][1][:temp][:max]
    expect(daily_weather).to have_key :min_temp
    expect(daily_weather[:min_temp]).to eq @data[:daily][1][:temp][:min]
    expect(daily_weather).to have_key :conditions
    expect(daily_weather[:conditions]).to eq(
      @data[:daily][1][:weather][0][:description]
    )
    expect(daily_weather).to have_key :icon
    expect(daily_weather[:icon]).to eq @data[:daily][1][:weather][0][:icon]
    expect(daily_weather).to_not have_key :temp
    expect(daily_weather).to_not have_key :pressure
    expect(daily_weather).to_not have_key :humidity
    expect(daily_weather).to_not have_key :dew_point
    expect(daily_weather).to_not have_key :wind_speed
    expect(daily_weather).to_not have_key :wind_deg
    expect(daily_weather).to_not have_key :weather
    expect(daily_weather).to_not have_key :clouds
    expect(daily_weather).to_not have_key :pop
    expect(daily_weather).to_not have_key :uvi
  end

  it 'has correctly formatted hourly_weather' do
    hourly_weather = @forecast.hourly_weather[0]

    expect(hourly_weather).to be_a Hash
    expect(hourly_weather).to have_key :time
    expect(hourly_weather[:time]).to eq(
      Time.at(@data[:hourly][1][:dt]).getlocal.strftime("%H:%M:%S")
    )
    expect(hourly_weather).to have_key :temperature
    expect(hourly_weather[:temperature]).to eq @data[:hourly][1][:temp]
    expect(hourly_weather).to have_key :wind_speed
    expect(hourly_weather[:wind_speed]).to eq(
      @data[:hourly][1][:wind_speed].to_s + " mph"
    )
    expect(hourly_weather).to have_key :wind_direction
    expect(hourly_weather[:wind_direction]).to eq(
      'from ' + @forecast.cardinal_direction(@data[:hourly][1][:wind_deg])
    )
    expect(hourly_weather).to have_key :conditions
    expect(hourly_weather[:conditions]).to eq(
      @data[:hourly][1][:weather][0][:description]
    )
    expect(hourly_weather).to have_key :icon
    expect(hourly_weather[:icon]).to eq(
      @data[:hourly][1][:weather][0][:icon]
    )
    expect(hourly_weather).to_not have_key(:pressure)
    expect(hourly_weather).to_not have_key(:humidity)
    expect(hourly_weather).to_not have_key(:dew_point)
    expect(hourly_weather).to_not have_key(:uvi)
    expect(hourly_weather).to_not have_key(:clouds)
    expect(hourly_weather).to_not have_key(:visibility)
    expect(hourly_weather).to_not have_key(:weather)
    expect(hourly_weather).to_not have_key(:pop)
  end
end
