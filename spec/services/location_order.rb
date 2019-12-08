require 'rails_helper'

RSpec.describe LocationOrder do
  describe '#order' do
    context 'mode of location listing' do
      before :each do
        @natal = create(:location, name: 'natal', latitude: -5.884859, longitude: -35.200299)
        @joao_camara = create(:location, name: 'joão câmara', latitude: -5.533122, longitude: -35.813800)
        @ceara_mirim = create(:location, name: 'ceara-mirim', latitude: -5.639382, longitude: -35.423956)
      end

      it 'when any type is define sort by created at' do
        ordered_locations = LocationOrder.new.order
        expect(ordered_locations.to_a).to eq [@natal, @joao_camara, @ceara_mirim]
      end

      it 'when the type is \'list\' sort alphabetically' do
        options = {mode: LocationOrder::LIST_MODE}
        ordered_locations = LocationOrder.new(options).order
        expect(ordered_locations.to_a).to eq [@ceara_mirim, @joao_camara, @natal]
      end

      describe 'mode map' do
        it 'when the type is \'map\' sort by proximity' do
          options = {
            mode: LocationOrder::MAP_MODE, lat: -8.064835, lng: -34.873495
          }
          ordered_locations = LocationOrder.new(options).order
          expect(ordered_locations.to_a).to eq [@natal, @ceara_mirim, @joao_camara ]
        end

        it 'when the type is \'map\' and no coordinates was pass throw an error' do
          options = { mode: LocationOrder::MAP_MODE }
          expect {
            LocationOrder.new(options).order
          }.to raise_error(RuntimeError)
        end
      end
    end
  end
end