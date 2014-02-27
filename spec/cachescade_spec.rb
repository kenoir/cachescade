require 'spec_helper'

describe Cachescade do
  let(:valid_options)   { subject.create([:slow_poke, :in_memory]) }
  let(:invalid_options) { subject.create([:foo, :bar]) }

  describe '.create(drivers)' do
    it 'returns Cachescade class' do
      expect(valid_options.class).to be Cachescade::Cachescade
    end

    context 'valid drivers' do
      it '@layers matches provided drivers' do
        valid_options.layers.each do |item|
          expect(item.class).to be Cachescade::CacheLayer
        end
      end
    end

    context 'invalid drivers' do
      it '@layers contains nil values' do
        invalid_options.layers.each do |item|
          expect(item).to be nil
        end
      end
    end
  end

  describe Cachescade::Cachescade do
    let(:foo) { 'foo value' }
    let(:bar) { 'bar value' }

    describe 'fetch(id)' do
      context 'found in first cache layer' do
        it 'returns correct value' do
          Cachescade::Drivers::InMemory
            .any_instance
            .stub(get: foo)

          expect(valid_options.fetch('foo'))
            .to eq foo
        end
      end

      context 'found in second cache layer' do
        it 'returns correct value' do
          Cachescade::Drivers::SlowPoke
            .any_instance
            .stub(get: bar)

          expect(valid_options.fetch('bar'))
            .to eq bar
        end
      end
    end

    describe 'write(id, data)' do
      it 'writes data to all layers' do
        valid_options.write('foo', foo).join # we use 'join' for purpose of the tests

        expect(valid_options.fetch('foo'))
          .to eq foo
      end
    end
  end
end
