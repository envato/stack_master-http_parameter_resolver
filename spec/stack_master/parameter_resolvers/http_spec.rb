# frozen_string_literal: true

RSpec.describe StackMaster::ParameterResolvers::Http do
  subject(:http) { described_class.new(config, stack_definition) }
  let(:config) { nil }
  let(:stack_definition) { nil }

  describe '#resolve' do
    subject(:resolve) { http.resolve(url) }

    let(:connection) { instance_spy(Faraday::Connection) }
    before do
      allow(Faraday).to receive(:new)
        .with(url: url, params: anything, headers: anything)
        .and_return(connection)
    end

    context 'given a URL https://www.cloudflare.com/ips-v4' do
      let(:url) { 'https://www.cloudflare.com/ips-v4' }

      context "and the HTTP servers returns:\n"\
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

      context 'and the HTTP servers returns 400 - not found' do
        before { allow(connection).to receive(:get).and_raise(Faraday::ResourceNotFound, 404) }
        specify { expect { resolve }.to raise_error(StackMaster::ParameterResolvers::Http::NotResolved) }
      end
    end
  end
end
