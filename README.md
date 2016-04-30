# Geo

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/geo`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'geo', git: 'git@gitlab.icar99.com:zc/geo.git', tag: 'v0.0.5'
```

And then execute:

    $ bundle

## Usage

### get all countries

```ruby
Geo.countries #=> Array of Locations: [location1, location2]

Geo.countries.where(code: ["1", "USA"]) #=> all countries by code '1' and 'USA'
Geo.countries.where(name: ["中国", "美国"]) #=> all countries by name '中国' and '美国'
```

```ruby
location1.code #=> "1"
location1.name #=> "中国"
```

### get one country

```ruby
Geo.country(1) #=> one country by code '1'
```

### get provinces/states by country_code

```ruby
Geo.provinces("1") #=> all provinces by code '1'
Geo.states("1")

Geo.provinces("1").where(code: ["11", "12"]) #=> all provinces of country_code '1' by code '11' and '12'
Geo.provinces("1").where(name: ["北京", "天津"]) #=> all provinces of country_code '1' by by name '北京' and '天津'
```

### get one province/state by country_code and province_code

```ruby
Geo.state(1, 13) #=> one province/state by code '1' and province_code '13'
```

### get cities by country_code and province_code

```ruby
Geo.cities("1", "11") #=> all cities by country_code '1' and province_code '11'
Geo.cities("1", "11").where(code: ["1"]) #=> all cities by country_code '1' and province_code '11' and city_code "1"
Geo.cities("1", "11").where(code: "1") #=> all cities by country_code '1' and province_code '11' and city_code "1"
```

### get city by country_code, province_code and city_code

```ruby
Geo.city(1, 13, 2) #=> one city by code '1', province_code '13' and city_code '2'
```

### get regions by country_code, province_code and city_code

```ruby
Geo.regions("1", "12", "1")
Geo.regions("1", "12", "1").where(code: "1") #=> all regions by country_code '1' and province_code '12' and city_code '1' and region_code '1'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/geo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request