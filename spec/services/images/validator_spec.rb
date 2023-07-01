require 'rails_helper'

RSpec.shared_examples 'Images::Validator' do
  describe '#check_file' do
    let(:response) { described_class.new(file_path).check_file }

    context 'when input file does not exist' do
      let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'invalid.txt') }
      let(:expected_response) do
        { error: "Error: File not found, File: #{file_path}" }
      end

      it 'returns an error' do
        expect(response).to eq(expected_response)
      end
    end

    context 'when the input file is empty' do
      let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'empty.txt') }
      let(:expected_response) do
        { error: "Error: File is empty, File: #{file_path}" }
      end

      it 'returns an error' do
        expect(response).to eq(expected_response)
      end
    end

    context 'when the input file is valid' do
      let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'valid.txt') }
      let(:expected_response) do
        { success: 'Valid File' }
      end

      it 'returns success result' do
        expect(response).to eq(expected_response)
      end
    end
  end

  describe '#check_url' do
    let(:response) { described_class.new('file_path').check_url(url) }

    context 'when the url is invalid' do
      let(:url) { 'thisiswrong' }
      let(:expected_response) do
        {
          error: "Error: URL scheme needs to be http or https: #{url}"
        }
      end

      it 'returns an error', :vcr do
        expect(response).to eq(expected_response)
      end
    end

    context 'when the url does not exist' do
      let(:url) { 'https://flxt.tmsimg.com/aoooosets/p183931_b_v8_ac.jpg' }
      let(:expected_response) do
        {
          error: "Error: 404 Not Found"
        }
      end

      it 'returns an error', :vcr do
        expect(response).to eq(expected_response)
      end
    end

    context 'when the url content is invalid' do
      let(:url) { 'https://www.rottentomatoes.com/tv/friends' }

      let(:expected_response) do
        {
          error: "Error: Url content is not an image"
        }
      end

      it 'returns an error', :vcr do
        expect(response).to eq(expected_response)
      end
    end

    context 'when the url is valid' do
      let(:url) { 'https://flxt.tmsimg.com/assets/p183931_b_v8_ac.jpg' }

      let(:expected_response) do
        {
          success: 'Valid URL',
          tempfile: an_instance_of(Tempfile)
        }
      end

      it 'returns success result', :vcr do
        expect(response).to include(expected_response)
      end
    end
  end
end
