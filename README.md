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

## Server Load

```
$ hulk load_test --url http://my_server.com/load_test_this
```

How much load the server can handle, the focus of this test, and what determines pass or fail, is the requests per minute.  Hulk will send as many requests it can at the server, using a configurable number of concurrent requests, and assert the total after one minute.


### Assert Requests Per Minute

Specify the rate of requests per minute you require

```
hulk load_test --assert_rpm 8000
```


## Scalability

```
$ hulk scale_test --url http://my_server.com/scale_test_this
```

How quick a specific request takes to respond.  The focus of this test, and what determines pass or fail, is the average response time.  Hulk will send a requests to the specified url for an amount of time and assert the average response time.

### Assert Response Time

in milliseconds

```
hulk scale_test --assert_res 200
```

## General Options

### Url

Defaults to using `http://localhost`

```
hulk command --url https://example.com/some_url
```

### Concurrent Requests

Defaults to 15

```
hulk command --concurrent_users 100
```

### Time to run

Defaults to 1 minute

```
hulk command --duration 10s
```

Can be any of the commands that [Siege](http://www.joedog.org/siege-home/) accepts.

### Local

Not enabled by default.  When enabled, hulk will ssh into the server you are hulking and will run the tests directly on the server.  The benifit is more accurate, and consistent results.

```
hulk command --local
```

### SSH Options

defaults to your current user

```
hulk command --ssh-user capistrano
```

### Verbose

Prints out the full report from Siege
