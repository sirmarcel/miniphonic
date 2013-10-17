# Miniphonic

Miniphonic is a small Ruby wrapper for the [auphonic]( https://auphonic.com ) API.

## Installation

Add this line to your application's Gemfile:

    gem 'miniphonic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install miniphonic

## Usage

First, set up Miniphonic:

```
Miniphonic.configure do |m|
  m.user = "user"
  m.password = "much secret wow"
end
```

You can then create an empty API object:

```
production = Miniphonic::Production.new
```

Alternatively, supply a uuid and run ```object.get_attributes``` to pull data from auphonic.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
