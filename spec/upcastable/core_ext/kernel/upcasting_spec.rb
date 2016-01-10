require 'spec_helper'

describe Kernel do
  let(:cat) { Cat.new }
  let(:animal) { cat.upcast_to(Animal) }

  describe '.method_added' do
    let(:ancestors) { Object.ancestors.reject { |a| a.is_a?(Class) } }

    it 'defines a delegate method' do
      ancestors.reverse.each do |ancestor|
        ancestor.class_eval { def object; @object; end }
        expect(animal.object).to be cat.object
      end
    end
  end
end
