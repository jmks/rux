# Rux

A Ruby port of Emac's `rx` library. `rx` allows you to construct regular expressions using human-readable functions (ymmv).

## Example

Consider words ending with `at` (e.g. cat, bat, fat, flat, mat, etc.). A regex might look like `/\b[a-z]at\b/`.

In `rx`, you might write something like this: `(rx bol (one-or-more letter) "at" eol)`.

In `rux`, this could be written:

```
Rux.rux do
  bow
  one_or_more letters
  literal "at"
  eow
end
```

`bow` is "beginning of word" and is aliased to `word_start`.

As the regex grows in complexity, the `rux` DSL starts to shine.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rux'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rux

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rux.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
