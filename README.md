# Github::Webhook::Auth

Simple gem / Rack middleware for forcing a valid Github Webhook

## Installation

Add this line to your application's Gemfile:

    gem 'github-webhook-auth'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install github-webhook-auth

## Usage

Set ENV['GITHUB_WEBHOOK_TOKEN'] to a secure value and then in your preferred
Rack configuration location for your webhook endpoint add:

    use Github::Webhook::Auth

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
