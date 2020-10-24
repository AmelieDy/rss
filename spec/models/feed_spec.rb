require 'rails_helper'


RSpec.describe Feed, type: :model do
  subject {
    described_class.new(title: "Anything",
                        url: "https://example.com")
  }
  context 'validation tests' do
    it 'ensures valid attributes' do
      expect(subject).to be_valid
    end
    it 'ensures title presence' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
    it 'ensures url presence' do
      subject.url = nil
      expect(subject).to_not be_valid
    end
    it 'ensures valid feed' do
    end

  end

  describe "Associations" do
    it { should have_many(:contents).without_validating_presence }
  end
end
