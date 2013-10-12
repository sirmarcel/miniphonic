require_relative 'helper'
require 'multi_json'

module Miniphonic

  describe ApiObject do
    
    describe '#endpoint' do
      it 'should raise an error if no endpoint is defined' do
        lambda do
          ApiObject.new.endpoint
        end.must_raise(NotImplementedError)
      end
    end

    describe '#create' do
      it 'should raise an error if no create method is defined' do
        lambda do
          ApiObject.new.create
        end.must_raise(NotImplementedError)
      end
    end

    describe '#create_with_payload' do
      before do

      end
    end

  end
end