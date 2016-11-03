RSpec.describe Task, type: :model do
  let(:now) { Time.now }
  let(:seven_days_from_now) { Time.now + 7.days }

  let(:created_task) { FactoryGirl.create(:task, name: 'task 1') }
  let(:update_params) do
    {
      id: created_task.id, name: 'first task !!', path: '/abc/dd',
      start_time: now, end_time: seven_days_from_now
    }
  end

  describe '.validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:path) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:agent_id) }
    it { should validate_inclusion_of(:status).in_array(TASK_STATUS_LIST) }
  end

  describe '.create' do
    subject { created_task }

    specify { expect(subject.id).not_to be_nil }
    specify { expect(subject.name).to eq 'task 1' }
  end

  describe '.update' do
    subject do
      created_task.update_attributes! update_params
      created_task
    end

    specify { expect(subject.name).to eq 'first task !!' }
    specify { expect(subject.path).to eq '/abc/dd' }
    specify { expect(subject.start_time).to eq now }
    specify { expect(subject.end_time).to eq seven_days_from_now }
  end
end
