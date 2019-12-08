class LocationOrder
  LIST_MODE = 'list'
  MAP_MODE = 'map'

  def initialize(options = {})
    @mode = options[:mode]
    @lat = options[:lat]
    @lng = options[:lng]
  end

  def order
    return raw_order if @mode.nil?
    return list_order if @mode == LIST_MODE
    return map_order if @mode == MAP_MODE
  end

  private

  def raw_order
    Location.order(:created_at)
  end

  def list_order
    Location.order(:name)
  end

  def map_order
    raise '"lat" and "lng" parameters are required' unless @lat && @lng

    Location.near(@lat, @lng)
  end
end
