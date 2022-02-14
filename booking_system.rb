require 'minitest/autorun'

class BookingError < StandardError
end


class BookingSystem


  def initialize

      @flights = {}

      (1..5).each do |f| # should be params

        seats = {}

        ('A'..'E').each do |s| # should be params, possibly per flight

          seats[s] = ""

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

    available = seats.select{ |k,v| v.empty? }

    if available.empty?

      raise BookingError, "No available seats!"
    end

    seat = available.keys.first

    flights[flight][seat] = passenger

    return "#{flight}#{seat}"

  end

  def generate_passenger_manifest flight

    unless flights.keys.include? flight

      raise BookingError, "Invalid flight number!"
    end

    manifest_data = flights[flight]

    manifest_output = []

    manifest_data.each do |seat,passenger|

      manifest_output << {seat: seat, passenger: passenger}
    end

    manifest_output
  end

  def cancel_booking confirmation

    seat_info = confirmation.chars

    flight = seat_info.first.to_i

    seat = seat_info.last


    unless flights.keys.include? flight

      raise BookingError, "Invalid flight number!"
    end

    flight_info = flights[flight]

    unless flight_info.keys.include? seat

      raise BookingError, "Invalid seat!"
    end

    flight_info[seat] = ""

    return true

  end

end

# Tests
describe BookingSystem do
  #  Step 3 Requirements
#  Implement cancel_booking
#  - cancel_booking should raise a BookingError if an invalid flight
#   is provided
#  - cancel_booking should raise a BookingError if an invalid seat
#   is provided
  describe "booking cancellation" do
    it 'should raise a BookingError when invalid flight number is given' do
      system = BookingSystem.new()

      assert_raises(BookingError) { system.cancel_booking("-1A") }
      assert_raises(BookingError) { system.cancel_booking("0A") }
      assert_raises(BookingError) { system.cancel_booking("6A") }
    end

    it 'should raise a BookingError when invalid seat letter is given' do
      system = BookingSystem.new()

      assert_raises(BookingError) { system.cancel_booking("11") }
      assert_raises(BookingError) { system.cancel_booking("1G") }
      assert_raises(BookingError) { system.cancel_booking("1&") }
    end

    it 'can cancel a booking' do
      system = BookingSystem.new()

      expected_manifest = [
        { "seat": "A", "passenger": "Jane" },
        { "seat": "B", "passenger": "" },
        { "seat": "C", "passenger": "Angela" },
        { "seat": "D", "passenger": "" },
        { "seat": "E", "passenger": "" },
      ]

      system.request_booking(1, "Jane")
      system.request_booking(1, "John")
      system.request_booking(1, "Angela")
      system.cancel_booking("1B");
      assert_equal expected_manifest, system.generate_passenger_manifest(1)
    end

    it 'rebooks an open seat after cancelled booking' do
      system = BookingSystem.new()

      expected_manifest = [
        { "seat": "A", "passenger": "Jane" },
        { "seat": "B", "passenger": "Fred" },
        { "seat": "C", "passenger": "Angela" },
        { "seat": "D", "passenger": "" },
        { "seat": "E", "passenger": "" },
      ]

      system.request_booking(4, "Jane")
      system.request_booking(4, "John")
      system.request_booking(4, "Angela")
      system.cancel_booking("4B")
      assert_equal "4B", system.request_booking(4, "Fred")
      assert_equal expected_manifest, system.generate_passenger_manifest(4)
    end
  end

  # Step 2 Requirements
# Implement get_flight_manifest
# - get_flight_manifest should throw a BookingError if an invalid flight
#   is provided
# - get_flight_manifest should return a full listing of seats and passengers
#   whether the seat has been assigned or not
# - The output of get_flight_manifest should be a list of objects; each
#   object should have a key of "seat" and a value of the seat letter and
#   a key of "passenger" and the name of the assigned passenger or an empty
#   string if the seat has not been assigned
# Example Format:
# [
#   { "seat": "A", "passenger": "Jane" },
#   { "seat": "B", "passenger": "John" },
#   { "seat": "C", "passenger": "Andy" },
#   { "seat": "D", "passenger": "" },
#   { "seat": "E", "passenger": "" },
# ]

  # Step two unit tests
  describe "getting a passenger manifest" do

    it 'should raise an error when invalid flight number is given' do
      system = BookingSystem.new()

      assert_raises(BookingError) { system.generate_passenger_manifest(-1) }
      assert_raises(BookingError) { system.generate_passenger_manifest(0) }
      assert_raises(BookingError) { system.generate_passenger_manifest(6) }
    end

    it 'can produce a passenger manifest' do
      system = BookingSystem.new()

      expected_manifest = [
        { "seat": "A", "passenger": "Jane" },
        { "seat": "B", "passenger": "John" },
        { "seat": "C", "passenger": "Andy" },
        { "seat": "D", "passenger": "" },
        { "seat": "E", "passenger": "" },
      ]

      system.request_booking(1, "Jane")
      system.request_booking(1, "John")
      system.request_booking(1, "Andy")
      assert_equal expected_manifest , system.generate_passenger_manifest(1)
    end

  end

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
