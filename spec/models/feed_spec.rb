require 'rails_helper'


RSpec.describe Feed, type: :model do
  subject {
    described_class.new(title: "Anything",
                        url: "https://www.touslesdrivers.com/php/scripts/news_rss.php")
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

  end

  context "Associations" do
    it { should have_many(:contents).without_validating_presence }
  end

  
end
