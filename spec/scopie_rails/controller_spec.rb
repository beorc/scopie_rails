# frozen_string_literal: true
require 'support/test_context'

describe ScopieRails::Controller do
  let(:controller_class) { Admin::HomeController }
  let(:controller_instance) { controller_class.new }
  let(:scopie_class) { Admin::HomeScopie }
  let(:target) { double }
  let(:scope_name) { :test_scope }
  let(:another_scope_name) { :another_scope }
  let(:hash) { { action: :index, scope_name => 'test' } }
  let(:options) { Hash.new }

  before(:each) do
    scopie_class.has_scope(scope_name, another_scope_name, options)
    controller_class.scopie_class = nil
  end

  describe '#find_scopie_class' do
    it 'should return scopie class' do
      expect(controller_instance.find_scopie_class).to eq scopie_class
    end

    context 'given custom scopie class' do
      let(:scopie_class) { Admin::SharedScopie }

      before(:each) do
        controller_class.scopie_class = scopie_class
      end

      it 'should return configured scopie class' do
        expect(controller_instance.find_scopie_class).to eq scopie_class
      end
    end
  end

  describe '#default_scopie' do
    it 'should return an instance of scopie class' do
      expect(controller_instance.default_scopie).to be_an_instance_of(scopie_class)
    end

    it 'should pass a controller instance to the scopie' do
      expect(controller_instance.default_scopie.controller).to eq controller_instance
    end
  end

  describe '#apply_scopes' do
    it 'should call scope method on the target' do
      expect(target).to receive(scope_name).once.with(hash[scope_name]).and_return(target)
      controller_instance.apply_scopes(target, hash: hash)
    end

    context 'given explicit hash' do
      it 'should call Scopie::apply_scopes with right options' do
        expect(Scopie).to receive(:apply_scopes).with(target, hash, method: hash[:action], scopie: controller_instance.default_scopie)
        controller_instance.apply_scopes(target, hash: hash)
      end
    end

    context 'given default hash' do
      let(:hash) { controller_instance.params }

      it 'should call Scopie::current_scopes with right options' do
        expect(Scopie).to receive(:apply_scopes).with(target, hash, method: hash[:action], scopie: controller_instance.default_scopie)
        controller_instance.apply_scopes(target)
      end
    end
  end

  describe '#current_scopes' do
    it 'should return a hash that contains scopes with its values' do
      scopes = controller_instance.current_scopes(hash: hash)
      expect(scopes).to eq({ scope_name => hash[scope_name] })
    end

    context 'given explicit hash' do
      it 'should call Scopie::current_scopes with right options' do
        expect(Scopie).to receive(:current_scopes).with(hash, method: hash[:action], scopie: controller_instance.default_scopie)
        controller_instance.current_scopes(hash: hash)
      end
    end

    context 'given default hash' do
      let(:hash) { controller_instance.params }

      it 'should call Scopie::current_scopes with right options' do
        expect(Scopie).to receive(:current_scopes).with(hash, method: hash[:action], scopie: controller_instance.default_scopie)
        controller_instance.current_scopes
      end
    end
  end
end
