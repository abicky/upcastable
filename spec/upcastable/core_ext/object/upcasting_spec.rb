require 'spec_helper'

describe Object do
  let(:cat) { Cat.new }
  let(:animal) { cat.upcast_to(Animal) }

  describe 'Upcasting' do
    context 'when the object is not upcasted' do
      it 'can call all instance methods' do
        expect { cat.run }.to_not raise_error
      end
    end

    context 'when the object is upcasted' do
      it 'raises NoMethodError on calling subclass methods' do
        expect { animal.run }.to raise_error(NoMethodError)
      end

      it 'raises NoMethodError on calling subclass methods via `send`' do
        expect { animal.send(:run) }.to raise_error(NoMethodError)
      end

      it 'is an instance of the original class' do
        expect(animal).to be_an_instance_of(cat.class)
      end

      it 'returns the same value of the original instance' do
        expect(animal.object_id).to be cat.object_id
      end
    end
  end

  describe '#upcast_to' do
    context 'when the object is not upcasted' do
      let(:upcasting) { Animal }

      it 'creates a Upcastable::UpcastedObject instance' do
        expect(Upcastable::UpcastedObject).to receive(:new).with(cat, upcasting)
        cat.upcast_to(upcasting)
      end
    end

    context 'when the ancestor is the original class' do
      it 'creates a Upcastable::UpcastedObject instance' do
        expect(Upcastable::UpcastedObject).to receive(:new).with(cat, cat.class)
        cat.upcast_to(cat.class)
      end
    end

    context 'when the ancestor is not an ancestor' do
      it 'raises ArgumentError' do
        expect { cat.upcast_to(String) }.to raise_error(ArgumentError)
      end
    end

    context 'when the object is already upcasted' do
      let(:upcasting) { Object }
      let(:reupcasting) { BasicObject }
      let!(:upcasted) { cat.upcast_to(upcasting) }

      context 'with a different ancestor' do
        it 'creates Upcastable::UpcastedObject with the original object' do
          expect(Upcastable::UpcastedObject).to receive(:new).with(cat, upcasting, reupcasting)
          upcasted.upcast_to(reupcasting)
        end
      end

      context 'with the same ancestor' do
        it 'returns self' do
          expect(Upcastable::UpcastedObject).to_not receive(:new)
          upcasted.upcast_to(upcasted.upcasting)
        end
      end
    end
  end

  describe '#upcasting' do
    subject { object.upcasting }

    context 'when the object is not upcasted' do
      let(:object) { cat }
      it { is_expected.to be_nil }
    end

    context 'when the object is upcasted' do
      let(:object) { animal }
      it { is_expected.to be Animal }
    end
  end

  describe '#upcasted?' do
    subject { object.upcasted? }

    context 'when the object is not upcasted' do
      let(:object) { cat }
      it { is_expected.to be false }
    end

    context 'when the object is upcasted' do
      let(:object) { animal }
      it { is_expected.to be true }
    end
  end

  describe '#downcast' do
    subject { object.downcast }

    context 'when the object is upcasted once' do
      let(:object) { cat.upcast_to(Object) }
      it { is_expected.to be cat }
    end

    context 'when the object is upcasted twice' do
      let(:object) { cat.upcast_to(Object).upcast_to(Kernel) }
      it { is_expected.to be cat }
    end
  end

  describe '#dup' do
    let(:cloned) { animal.dup }

    it 'does not preserve upcasted state' do
      expect(cloned.upcasted?).to be false
    end
  end

  describe '#clone' do
    let(:cloned) { animal.clone }

    it 'preserves upcasted state' do
      expect(cloned.upcasted?).to be true
      expect(cloned.downcast).to_not be animal.downcast
      expect(animal.downcast).to be cat
    end
  end

  describe '#respond_to?' do
    subject { object.respond_to?(:run) }

    context 'when the object is not upcasted' do
      let(:object) { cat }
      it { is_expected.to be true }
    end

    context 'when the object is upcasted' do
      let(:object) { animal }
      it { is_expected.to be false }
    end
  end
end
