require 'github-webhook-auth'

describe 'protecting a webhook api endpoint' do

  let(:app)        { double 'rack stack', :call => result }
  let(:result)     { double 'result' }
  let(:middleware) { Github::Webhook::Auth.new(app) }
  let(:secret)     { 'S0m3Key' }

  before do
    stub_const("ENV", 'SECRET_TOKEN' => secret)
  end

  context 'when a valid auth token is provided' do
    let(:env)       { { 'HTTP_X_HUB_SIGNATURE' => signature, 'rack.input' => body } }
    let(:body)      { StringIO.new }
    let(:hexdigest) { OpenSSL::Digest::Digest.new('sha1') }
    let(:signature) { 'sha1='+OpenSSL::HMAC.hexdigest(hexdigest, secret, body.read) }

    it 'calls the app and returns its response' do
      expect(app).to receive(:call).with(env)
      expect(middleware.call(env)).to eq result
    end
  end

  context 'when an invalid auth token is provided' do
    let(:env) { { 'HTTP_X_HUB_SIGNATURE' => 'notatoken', 'rack.input' => StringIO.new } }

    it 'short circuits the app' do
      expect(app).to_not receive(:call).with(env)
      middleware.call(env)
    end

    it 'returns a 401 status' do
      expect(middleware.call(env)[0]).to eq 401
    end
  end

  context 'when no auth token is provided' do
    let(:env) { { 'rack.input' => StringIO.new } }

    it 'short circuits the app' do
      expect(app).to_not receive(:call).with(env)
      middleware.call(env)
    end

    it 'returns a 401 status' do
      expect(middleware.call(env)[0]).to eq 401
    end
  end

end
