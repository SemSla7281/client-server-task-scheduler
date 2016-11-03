RSpec.describe Tasks::Crud do
  let(:now) { Time.now }
  let(:seven_days_from_now) { Time.now + 7.days }
  let(:agent) { FactoryGirl.create(:agent) }

  let(:created_task) { FactoryGirl.create(:task) }

  let(:create_params) do
    {
      name: 'ttt1', path: '/sdsf/', arguments: 'f f', start_time: now,
      end_time: seven_days_from_now, agent_id: agent.id,
      weekdays: %w(wednesday tuesday)
    }
  end

  let(:update_params) do
    {
      id: created_task.id, name: 'ttt2', path: '/aa/bb', arguments: nil,
      start_time: now + 1.day, end_time: seven_days_from_now - 2.days,
      agent_id: agent.id, weekdays: %w(saturday)
    }
  end

  describe '.create' do
    subject { Tasks::Crud.new(create_params).create }

    specify { expect(subject.id).not_to be_nil }
    specify do
      json = subject.as_json(only: create_params.keys).symbolize_keys
      expect(json).to eq create_params
    end
  end

  describe '.update' do
    subject { Tasks::Crud.new(update_params).update }

    specify { expect(subject.id).to eq created_task.id }
    specify do
      json = subject.as_json(only: update_params.keys).symbolize_keys
      expect(json).to eq update_params
    end
  end

  describe '.destroy' do
    specify do
      Tasks::Crud.new(id: created_task.id).destroy
      task = Task.where(id: created_task.id).first
      expect(task).to be_nil
    end
  end
end
