require 'spec_helper'
describe 'wi' do
  context 'with default values for all parameters' do
    it { should contain_class('wi') }
  end
end
