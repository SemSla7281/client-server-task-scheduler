RSpec.describe Agent, type: :model do
  let(:created_agent) { FactoryGirl.create(:agent, secret_key: 's1', decode_key: 'd1') }
  let(:update_params) { { secret_key: 's2', decode_key: 'd2' } }

  describe '.validations' do
    it { should validate_presence_of(:secret_key) }
    it { should validate_presence_of(:decode_key) }
  end

  describe '.create' do
    subject { created_agent }

    specify { expect(subject.id).not_to be_nil }
    specify { expect(subject.secret_key).to eq 's1' }
    specify { expect(subject.decode_key).to eq 'd1' }
  end

  describe '.update' do
    subject do
      created_agent.update_attributes! update_params
      created_agent
    end

    specify { expect(subject.secret_key).to eq 's2' }
    specify { expect(subject.decode_key).to eq 'd2' }
  end
end
