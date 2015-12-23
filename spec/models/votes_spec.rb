require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :voter }
  it { should belong_to :votee }
  it { should validate_presence_of(:voter_id) }
  it { should validate_uniqueness_of(:voter_id).scoped_to(:votee_id) }
  it { should validate_presence_of(:votee_id) }
end
