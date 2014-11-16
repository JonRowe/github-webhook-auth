require 'github-webhook-auth'

describe 'protecting a webhook api endpoint' do

  let(:app)        { double 'rack stack', :call => result }
  let(:env)        { double 'env' }
  let(:result)     { double 'result' }
  let(:middleware) { Github::Webhook::Auth.new(app) }

  it 'calls the app and returns its response' do
    expect(app).to receive(:call).with(env)
    expect(middleware.call(env)).to eq result
  end

end
