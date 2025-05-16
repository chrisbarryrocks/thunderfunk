require 'rails_helper'

RSpec.describe ThunderFunkVibesService do
  describe 'get_vibes' do
    it 'returns the correct song for the condition' do
      result = ThunderFunkVibesService.get_vibes("Sunny")
      expect(result[:title]).to eq("Gramatik - Just Jammin'")
      expect(result[:url]).to eq("https://www.youtube.com/embed/xTA_FexW3qU?si=-24uKliID_MvHyRa")
    end

    it 'returns the default song when we do not find a match' do
      result = ThunderFunkVibesService.get_vibes("Apocalyptic Firestorm")
      expect(result[:title]).to eq("Herbie Hancock - Cantaloupe Island")
      expect(result[:url]).to eq("https://www.youtube.com/embed/8B1oIXGX0Io?si=Cx6zBxQ03lRSikiM")
    end
  end
end
