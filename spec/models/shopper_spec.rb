require 'rails_helper'

RSpec.describe Shopper, :type => :model do

  describe '#fields' do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:user_id).of_type(:integer) }
  end

  describe '#associations' do
    it { should have_many(:sales).dependent(:restrict_with_exception) }
    it { should belong_to(:user) }
  end

  describe '#validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2) }
    it { should validate_presence_of(:user) }
  end

  describe '#scopes' do
    let(:account) { create :user }

    context 'ordered by name' do
      let(:shopper_one) { create :valid_shopper, name: 'Fulano', user: account }
      let(:shopper_two) { create :valid_shopper, name: 'Beltrano', user: account }

      it { expect(described_class.ordered(account)).to match_array([shopper_two, shopper_one]) }
    end
  end

  describe '#factories' do
    it { expect(build :valid_shopper).to be_valid }
    it { expect(build :invalid_shopper).to_not be_valid }
  end

end
