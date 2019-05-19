require './lib/airport'
require './lib/plane'
require './lib/weather'

describe Airport do

  let(:airport) {Airport.new}
  let(:plane) {double :plane}
  let(:weather) {double :weather}

  it 'can respond to land' do
    expect(airport).to respond_to(:land)
  end
  
  it 'expects planes can land at the airport' do
    allow(weather).to receive(:stormy) {false}
    airport.land(plane) # => num of planes  = 1
    output = airport.planes.length
    expect(output).to eq(1)
  end

  it 'can add planes to the planes array total' do
    allow(weather).to receive(:stormy) {false}
    5.times {airport.land(plane)}
    output = airport.planes.length
    expect(output).to eq(5)
  end

  it 'can respond to plane_takeoff' do
    expect(airport).to respond_to(:plane_takeoff)
  end

  it 'expects planes can leave the airport' do
    allow(weather).to receive(:stormy) {false}
    airport.land(plane) # => num of planes should = 1
    airport.plane_takeoff
    output = airport.planes.length
    expect(output).to eq(0)
  end

  it 'can raise an error if there are no planes to take-off' do 
    expect { airport.plane_takeoff }.to raise_error("There are no planes in the airport")
  end

  it 'prevents plane take-off when weather is stormy' do
    allow(weather).to receive(:stormy) {true}
    airport.land(plane)
    expect { airport.plane_takeoff }.to raise_error("Plane cannot take-off due to stormy weather")
  end
 
  it 'prevents plane landing when weather is stormy' do
    allow(weather).to receive(:stormy) {true}
    expect { airport.land(plane) }.to raise_error("Plane cannot land due to stormy weather")
  end

  it 'prevents a plane landing if the airport is full' do
    aiport.capacity.times {airport.land(plane)}
    expect{airport.land(plane)}.to raise_error('Airport at full capacity')
  end

  # it 'has a default capacity if no capacity argument is passed' do
  #   expect(airport.capacity).to eq(Airport::DEFAULT_CAPACITY)
  # end



end