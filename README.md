# Hulk

Hulk is designed to provide automated scalability testing over http or https.  The desire is to have Jenkins run a job that runs load and scalability tests, using siege, on a specific server and to assert those results, using Rspec.

# How to use

Install [Siege](http://www.joedog.org/siege-home/) on the server you wish to perform the the hulking.

```
$ brew install siege
```

Install as a ruby gem, this requires ruby 1.9.3 and will install a binary to your system.

```
$ gem install hulk
```

There are two things that Hulk is designed to test. Server Load and Scalability.

## CLI

You can run your tests from the command line

```
$ hulk load_test --url http://my_server.com/load_test_this
```

view [using the CLI](https://github.com/ionicmobile/hulk/wiki/Using-the-CLI) for more info

## Ruby API

You can use hulk in your Ruby API to create more custom test suites.

```
yet to be defined
```

view [using the ruby api in your code](https://github.com/ionicmobile/hulk/wiki/Using-the-ruby-api-in-your-code) for more info