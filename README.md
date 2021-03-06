# Hulk Smash

Hulk is a ruby library that provides scalability and load testing, through [siege](http://www.joedog.org/siege-home/).

# How to use

Install [Siege](http://www.joedog.org/siege-home/) on the server you wish to perform the the hulking.

```
$ brew install siege
```

Install as a ruby gem, this requires ruby 1.9.3 and will install a binary to your system.

```
$ gem install hulk_smash
```

There are two things that Hulk is designed to test. Server Load and Scalability.

## Defaults

* 5 seconds
* 15 concurrent users
* http://localhost

Require the library, and create a new smasher.

```ruby
require 'hulk_smash'
smasher = HulkSmash::Smasher.new
smasher = HulkSmash::Smasher.new 'https://myhost.com/hit_it', duration: '1m', method: :put, data: { foo: 'bar' }
```

### Runs load test to get idea of requests per second

```ruby
smasher.run_load_test
# or
smasher.load_test = true
smasher.run

smasher.result.requests_per_second # => 1327.1 
smasher.result.avg_response_time # => 10
```

### Runs scalability test to get idea of response time

```ruby
smasher.run_scalability_test
# or
smasher.run

smasher.result.requests_per_second # => 22.13 
smasher.result.avg_response_time # => 5
```

## Custom Options

* 1 minute
* 100 concurrent users
* http://some_great_host/assets/scale-test.txt

```ruby
smasher = HulkSmash::Smasher.new 'http://some_great_host/assets/page_to_test', duration: '1m', concurrent_users: 100

result = smasher.run_load_test
result.requests_per_second # => 477.38
result.avg_response_time # => 150
```

# Rspec

Create a test suite that asserts on response times and throughput.  View the [examples](https://github.com/ionicmobile/hulk_smash/tree/master/examples) and [integration specs](https://github.com/ionicmobile/hulk_smash/tree/master/spec/integration) for inspiration

The initial reason for writing this is so I can create a test suite written in ruby that tests http services  notify me when we push a release that makes the services slow.

# Contribute

## Code

* Fork
* Branch for your topic / issue
* Make pull request with updated tests

## Documentation

Make the documentation better! I'd like to use [Yardoc](http://yardoc.org)

## Examples

Contribute some examples on how you use this.