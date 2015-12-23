require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :voter }
  it { should belong_to :votee }
end
