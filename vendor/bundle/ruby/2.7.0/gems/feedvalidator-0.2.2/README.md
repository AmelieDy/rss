# FeedValidator [![Build Status](https://travis-ci.org/edgar/feedvalidator.png?branch=master)](https://travis-ci.org/edgar/feedvalidator) [![Gem Version](https://badge.fury.io/rb/feedvalidator.svg)](http://badge.fury.io/rb/feedvalidator)

FeedValidator is an interface to the [W3C Feed Validation online service](http://validator.w3.org/feed/),
based on its SOAP 1.2 support.

It helps to find errors in RSS or ATOM feeds.

FeedValidator add a new assertion (`assert_valid_feed`) which you can use in Rails applications.
This assertion implements a cache to improve the performance of the tests and to not abuse of the
[W3C Feed Validation online service](http://validator.w3.org/feed/)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'feed_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feed_validator


## Examples

* For use FeedValidator just do this:

    ```ruby
    require 'feed_validator'

    v = W3C::FeedValidator.new()
    v.validate_url('http://www.w3.org/QA/news.rss')
    puts v.to_s unless v.valid?
    ```

* In Rails you can use it in your functional tests, just modify your /test/test_helper.rb adding this line:

    ```ruby
    require 'feed_validator/assertions'
    ```

  And now you can use in your functional test, in this way:

    ```ruby
    def test_bar_valid_feed
      get :bar
      assert_valid_feed
    end
    ```

  Or use the class-level method to quickly create validation tests for a bunch of actions at once:

    ```ruby
    assert_valid_feed :bar, :foo
    ```

## Documentation

Documentation can be found at

* http://feedvalidator.rubyforge.org

## License

FeedValidator is released under the MIT license.
