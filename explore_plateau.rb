require_relative 'nasa_station'

input = "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

station = Station.new(input)

station.explore
