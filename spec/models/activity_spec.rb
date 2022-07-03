# frozen_string_literal: true

RSpec.describe Activity, type: :model do
  let(:activity) { build :activity }

  describe 'validations' do
    it { is_expected.not_to be_valid }

    it 'valid with event' do
      expect(activity).to be_valid
    end
  end

  describe '#leader_result' do
    it 'returns best male result' do
      FactoryBot.rewind_sequences
      activity = create :activity
      activity.results << build_list(:result, 3, activity_id: nil)
      expect(activity.leader_result.position).to eq 1
    end
  end

  describe '#add_results_from_timer' do
    context 'when argument is nil' do
      it 'returns nil' do
        expect(activity.add_results_from_timer(nil)).to be_nil
      end
    end

    context 'with timer file' do
      let(:file_timer) { File.open('spec/fixtures/files/parkrun_timer_results.csv') }

      it 'appends result to activity' do
        expect { activity.add_results_from_timer(file_timer) }.to change(activity.results, :size).to(5)
      end

      it 'change activity date according to timer file' do
        date = Date.parse('23/04/2022')
        expect { activity.add_results_from_timer(file_timer) }.to change(activity, :date).to(date)
      end
    end
  end
end
