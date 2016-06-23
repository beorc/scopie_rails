# frozen_string_literal: true

module Admin
  class HomeController

    include ScopieRails::Controller

  end

  module Scopies
    class HomeScopie < ScopieRails::Base
    end
  end
end

describe ScopieRails do
  let(:controller_instance) { Admin::HomeController.new }

  it 'has a version number' do
    expect(ScopieRails::VERSION).not_to be nil
  end

  describe '.find_scopie_class' do
    it 'should return scopie class' do
      expect(controller_instance.find_scopie_class('Admin::HomeController')).to eq Admin::Scopies::HomeScopie
    end
  end

  describe '.apply_scopes' do
    let(:scopie_class) { Admin::Scopies::HomeScopie }
    let(:target) { double }
    let(:scope_name) { :test_scope }
    let(:another_scope_name) { :another_scope }
    let(:hash) { { action: :index, scope_name => 'test' } }
    let(:options) { Hash.new }

    before(:each) { scopie_class.has_scope(scope_name, another_scope_name, options) }

    it 'should call scope method on the target' do
      expect(target).to receive(scope_name).once.with(hash[scope_name]).and_return(target)
      controller_instance.apply_scopes(target, hash: hash)
    end
  end

  describe '.current_scopes' do
    let(:scopie_class) { Admin::Scopies::HomeScopie }
    let(:target) { double }
    let(:scope_name) { :test_scope }
    let(:another_scope_name) { :another_scope }
    let(:hash) { { action: :index, scope_name => 'test' } }
    let(:options) { Hash.new }

    before(:each) { scopie_class.has_scope(scope_name, another_scope_name, options) }

    it 'should return a hash that contains scopes with its values' do
      scopes = controller_instance.current_scopes(hash: hash)
      expect(scopes).to eq({ scope_name => hash[scope_name] })
    end
  end
end
