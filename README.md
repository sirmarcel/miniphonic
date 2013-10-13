# Miniphonic

TODO: Write a gem description

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

Create a production
```
production = Miniphonic::Production.new
production.create
```

Run a production
```
production.start
```

Example:
```
require 'miniphonic'

Miniphonic.configure do |m|
  m.user = "user"
  m.password = "much secret wow"
end

production = Miniphonic::Production.new
production.meta = {"title" => "Wheee"}
production.outfiles << { "format" => "mp3" }
production.create
production.set_outfiles
production.upload("test.m4a")
production.start
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
