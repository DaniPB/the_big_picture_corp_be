require 'services/images/validator_spec'
require 'rails_helper'

RSpec.describe Images::Downloader do
  include_examples 'Images::Validator'

  describe '#call' do
    subject { described_class.new(file_path) }

    let(:response) { subject.call }

    let(:error_file_response) do
      { error:  "Error: File #{file_path}, not found" }
    end

    let(:success_file_response) do
      { success: 'Valid File' }
    end

    context 'when validator response has an error' do
      let(:file_path) { '/file/path.txt' }

      before do
        expect_any_instance_of(Images::Validator)
          .to receive(:check_file)
          .and_return(error_file_response)
      end

      it 'returns an error' do
        expect(response).to eq(response)
      end
    end

    context 'when there are some errors when downloading' do
      let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'some_images_valid.txt') }

      let(:expected_response) do
        {
          images_downloaded: 1,
          errors: [
            {
              error: "Error: 404 Not Found",
              url: "https://flxt.tmsimg.com/asts/p183931_b_v8_ac.jpg"
            },
            {
              error: "Error: 404 Not Found",
              url: "https://img.welt.de/img/kultur/mobi378737/8862501407-ci102l-w1024/TV-Serie-Friends.jpg"
            }
          ]
        }
      end

      before do
        expect_any_instance_of(Images::Validator)
          .to receive(:check_file)
          .and_return(success_file_response)
      end

      it 'returns errors for the images that were not downloaded' do
        expect(response).to eq(expected_response)
      end

      it 'saves the valid images in the hard drive' do
        expect(subject).to receive(:save_in_hard_drive).once

        response
      end
    end

    context 'when validator response is success' do
      let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'all_images_valid.txt') }

      let(:expected_response) do
        {
          images_downloaded: 3,
          errors: []
        }
      end

      before do
        expect_any_instance_of(Images::Validator)
          .to receive(:check_file)
          .and_return(success_file_response)
      end

      it 'downloads the images' do
        expect(response).to eq(expected_response)
      end

      it 'saves the images in the hard drive' do
        expect(subject).to receive(:save_in_hard_drive).exactly(3).times

        response
      end
    end
  end
end
