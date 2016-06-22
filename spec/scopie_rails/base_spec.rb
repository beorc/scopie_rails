# frozen_string_literal: true

describe ScopieRails::Base do
  describe '#initialize' do
    let(:controller) { :controller }
    let(:described_instance) { described_class.new(controller) }

    it 'should store the controller' do
      expect(described_instance.controller).to eq :controller
    end
  end
end
