class TherapistSearch
  def initialize(searcher)
    @searcher  = searcher
    @distance  ||= 50
  end

  attr_reader :distance, :searcher

  def set_distance(range)
    @distance = range
  end

  def find
    Therapist.where.not(verified_at: nil)
      .near([searcher.latitude, searcher.longitude], distance)
  end

  def set_location(address)
    @searcher = Geocoder.search(address).first
  end
end
