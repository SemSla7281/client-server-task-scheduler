RSpec.describe Tasks::Scheduler do
  let(:full_week) { FactoryGirl.create(:task, :full_week) }
  let(:partial_week) { FactoryGirl.create(:task, :partial_week) }

  describe '.schedule' do
    context 'with date_check' do
      subject { Tasks::Scheduler.new(full_week).schedule }

      specify { expect(subject.count).to eq 8 }
    end

    context 'with weekday_check' do
      subject { Tasks::Scheduler.new(partial_week).schedule }

      specify { expect(subject.count).to eq 2 }
    end
  end
end
l
