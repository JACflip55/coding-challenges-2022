require 'minitest/autorun'

class BookingError < StandardError
end


class BookingSystem
  
  
  def initialize
    
      @flights = {}
      
      (1..5).each do |f|
        
        seats = {}
                
        ('A'..'E').each do |s|
          
          seats[s] = nil
          
        end
        
        flights[f] = seats
        
      end
    
  end
  attr_accessor :flights
  
  def request_booking flight, passenger
    
    if passenger.empty?
    
      raise BookingError, "No passenger!"
    end
    
    unless flights.keys.include? flight
      
      raise BookingError, "Invalid flight number!"
    end
    
    seats = flights[flight]
    
    available = seats.select{ |k,v| v.nil? }
    
    if available.empty?
      
      raise BookingError, "No available seats!"
    end
    
    seat = available.keys.first
    
    flights[flight][seat] = passenger
    
    return "#{flight}#{seat}"
    
  end
end

# Tests
describe BookingSystem do
  describe "making a reservation" do
    it 'can request a reservation' do
      system = BookingSystem.new()

      assert_equal "1A", system.request_booking(1, "Jane")
      assert_equal "1B", system.request_booking(1, "John")
      assert_equal "3A", system.request_booking(3, "Jane")
      assert_equal "3B", system.request_booking(3, "John")
    end

    it 'raises an error when invalid flight requested' do
      system = BookingSystem.new()

      assert_raises(BookingError) { system.request_booking(0, "Jane") }
      assert_raises(BookingError) { system.request_booking(6, "Jane") }
    end

    it 'raises an error when no passenger name is provided' do
      system = BookingSystem.new()

      assert_raises(BookingError) { system.request_booking(1, "") }
    end

    it 'raises an error when a flight is full' do
      system = BookingSystem.new()

      assert_equal "1A", system.request_booking(1, "Jane")
      assert_equal "1B", system.request_booking(1, "John")
      assert_equal "1C", system.request_booking(1, "Andy")
      assert_equal "1D", system.request_booking(1, "Angela")
      assert_equal "1E", system.request_booking(1, "Kat")

      assert_raises(BookingError) do
        system.request_booking(1, "Tom")
      end
    end
  end
end
