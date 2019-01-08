require 'spec_helper'

describe Api::Authentication do
  subject { described_class.new('login', 'password') }

  api_host_defined

  describe '.valid_credentials?' do
    before do
      allow(subject).to receive(:auth_key).and_return('key')
      stub_request(:post, 'api.smartvpn.biz/api/auth').
        to_return(status: status)
    end

    context 'status 200' do
      let(:status) { 200 }

      it 'returns true' do
        expect(subject.valid_credentials?).to be true
      end
    end

    context 'status 404' do
      let(:status) { 404 }

      it 'returns false' do
        expect(subject.valid_credentials?).to be false
      end
    end
  end
end
