# frozen_string_literal: true

RSpec.describe StackMaster::ParameterResolvers::Http do
  subject(:http) { described_class.new(config, stack_definition) }
  let(:config) { nil }
  let(:stack_definition) { nil }

  describe '#resolve' do
    subject(:resolve) { http.resolve(args) }

    let(:connection) { instance_spy(Faraday::Connection) }
    before do
      allow(Faraday).to receive(:new)
        .with(url: url, params: anything, headers: anything)
        .and_return(connection)
    end
    let(:args) { {'url' => url, 'strategy' => strategy} }
    let(:url) { nil }

    context 'given the strategy "one_per_line"' do
      let(:strategy) { 'one_per_line' }

      context 'and a URL https://www.cloudflare.com/ips-v4' do
        let(:url) { 'https://www.cloudflare.com/ips-v4' }

        context "and the HTTP server returns:\n"\
                "173.245.48.0/20\n"\
                "103.21.244.0/22\n"\
                '103.22.200.0/22' do
          before { allow(connection).to receive(:get).and_return(response) }
          let(:response) do
            instance_spy(Faraday::Response, body: <<~BODY)
              173.245.48.0/20
              103.21.244.0/22
              103.22.200.0/22
            BODY
          end

          it { should eq(%w[173.245.48.0/20 103.21.244.0/22 103.22.200.0/22]) }
        end

        context 'and the HTTP server returns 400 - not found' do
          before { allow(connection).to receive(:get).and_raise(Faraday::ResourceNotFound, 404) }
          specify { expect { resolve }.to raise_error(StackMaster::ParameterResolvers::Http::NotResolved) }
        end
      end
    end

    context 'given the (non-existing) strategy "typo"' do
      let(:strategy) { 'typo' }
      let(:url) { 'https://www.cloudflare.com/ips-v4' }
      specify { expect { resolve }.to raise_error(StackMaster::ParameterResolvers::Http::Misconfigured) }
    end

    context 'given a URL but no strategy' do
      let(:args) { {'url' => 'https://www.cloudflare.com/ips-v4'} }
      specify { expect { resolve }.to raise_error(StackMaster::ParameterResolvers::Http::Misconfigured) }
    end

    context 'given a strategy but no URL' do
      let(:args) { {'strategy' => 'one_per_line'} }
      specify { expect { resolve }.to raise_error(StackMaster::ParameterResolvers::Http::Misconfigured) }
    end

    context 'given a string' do
      let(:args) { 'https://www.cloudflare.com/ips-v4' }
      specify { expect { resolve }.to raise_error(StackMaster::ParameterResolvers::Http::Misconfigured) }
    end
  end
end
