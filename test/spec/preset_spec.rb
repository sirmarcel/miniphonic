require_relative 'helper'

module Miniphonic

  describe Preset do

    describe '#endpoint' do
    
      it 'must define the right endpoint' do
        Preset.new.endpoint.must_equal("preset")
      end
      
    end

  end

end