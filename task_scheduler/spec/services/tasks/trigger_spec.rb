RSpec.describe Tasks::Trigger do
  let(:prefix) { 'task1' }

  before(:all) do
    Agent.destroy_all
    RedisAccess.tasks.keys.each { |key| RedisAccess.tasks.del key }
    @task = FactoryGirl.create(:task)
  end

  describe '.clean' do
    context 'before clean' do
      subject do
        Tasks::Scheduler.new(@task).schedule
        RedisAccess.tasks.keys.count
      end

      specify { expect(subject).to be > 0 }
    end

    context 'after clean' do
      subject do
        Tasks::Trigger.new(@task)
        RedisAccess.tasks.keys.count
      end

      specify { expect(subject).to eq 0 }
    end
  end

  describe '.set' do
    subject do
      Tasks::Trigger.new(@task, [50, 100]).set
      RedisAccess.tasks.keys.count
    end

    specify { expect(subject).to eq 2 }
  end
end
