require 'rails_helper'
require 'carrierwave/test/matchers'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  before(:all) do
    AvatarUploader.enable_processing = true
  end

  before(:each) do
    @uploader = AvatarUploader.new(mock_model(User).as_null_object)
    @uploader.store!(File.open('spec/fixtures/missing.jpg'))
  end

  after(:all) do
    AvatarUploader.enable_processing = false
  end

  context 'the default version' do
    it 'scales down an image to be no larger than 100 by 100 pixels' do
      expect(@uploader).to be_no_larger_than(100, 100)
    end
  end

  context 'the thumb version' do
    it 'scales down an image to be no larger than 50 by 50 pixels' do
      expect(@uploader.thumb).to have_dimensions(50, 50)
    end
  end
end
