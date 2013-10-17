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
require 'miniphonic'

Miniphonic.configure do |m|
  m.user = "your username"
  m.password = "much secret wow"
end
```

*Quick start:* Read ```lib/miniphonic/api_object.rb``` and (maybe) ```lib/miniphonic/production.rb```/```lib/miniphonic/preset.rb```. This is really basic software.

### General

Both, productions and presets, are API objects and share most methods. They are simple Ruby objects:


```
production = Miniphonic::Production.new
preset = Miniphonic::Preset.new
```

On the server side, those objects are identified by their ```uuid```. If you already have one, you can create a new API object with a uuid:

```
production = Miniphonic::Production.new("SjRqGhxKhK448Gs6AgAzcZ")
```

You usually get one by creating your API object on the server side:
```
production.create
# => production.uuid = "SjRqGhxKhK448Gs6AgAzcZ"
```

Usually, you actually want to do something useful, so you need to add some attributes to your API objects. Miniphonic exposes the "top level" of attributes in dot notation, the rest is handled by the appropriate data structure. Take a look at [this page]( https://auphonic.com/api-docs/details.html#one-request ) or ```{prest|production}_attributes.rb``` to see what you can do. 

Quick example:
```
production.metadata[:title] = "Hello there, internet"
production.output_files << {format: "mp3"}
```

If you set attributes before running ```create```, they will be sent with the creation request, otherwise, use ```object.update``` to set the attributes on the server side.

You can get attributes from the server (thus overwriting the one in your local API object!) by running ```get_attributes```, provided your object already has a ```uuid```.

### Productions

You can upload an input file (to production with a uuid) by running

```
production.upload_audio("path/to/file")
```

Or use one from an external service:
```
production.upload_audio_from_service("file.m4a","service_uuid")
```

Set outfiles:
```
production.output_files << {format: "mp3", basename: "my_file"}
```

Start and stop productions (if you have provided an input file and at least one output file):

```
production.start
production.stop
```

### Presets

Presets have a lot less fancy methods than productions, but they work pretty much the same. 
One caveat: You can't create presets without setting ```preset.name``` first.

***

Refer to the [API docs]( https://auphonic.com/api-docs/details.html ), the specs and the appropriate classes for further information. 

Do some good now.

<3


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
