require 'rails_helper'

describe ConceptHelper, type: :helper do
  let!(:activity_session) { FactoryGirl.create(:activity_session) }
  let(:punctuation_concept) { FactoryGirl.create(:concept, name: 'Punctuation') }
  let(:prepositions_concept) { FactoryGirl.create(:concept, name: 'Prepositions') }

  describe '#all_concept_stats' do
    before do
      activity_session.concept_results.create!(
        concept: punctuation_concept,
        metadata: {
          correct: 0
        }
      )
      activity_session.concept_results.create!(
        concept: prepositions_concept,
        metadata: {
          correct: 1
        }
      )
    end

    it 'displays all concept stats for an activity session' do
      html = helper.all_concept_stats(activity_session)
      expect(html).to include(punctuation_concept.name)
      expect(html).to include(prepositions_concept.name)
    end

    it 'displays a breakdown of the grammar concepts and correct/incorrect' do
      html = helper.all_concept_stats(activity_session)
      expect(html).to include(prepositions_concept.name)
      expect(html).to include('1')
      expect(html).to include('0')
    end
  end
end
