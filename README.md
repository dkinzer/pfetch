# Pfetch

Defines the pfetch executable script that given a query string and an optional sorting argument returns a combined result set from various endpoints.

## Installation

From the source code root directory run the following commands:

```
gem build
gem install pfetch
```

## Usage

`pfetch "hello world"`

`pfetch "hello world" --sort-by=relevance`



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dkinzer/pfetch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dkinzer/pfetch/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pfetch project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dkinzer/pfetch/blob/main/CODE_OF_CONDUCT.md).
