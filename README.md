## ScopieRails

[![Code Climate](https://codeclimate.com/github/beorc/scopie_rails/badges/gpa.svg)](https://codeclimate.com/github/beorc/scopie_rails)

[Scopie][s] for Rails

It is similar to [has_scope](http://github.com/plataformatec/has_scope).

The key differences are:

* Dedicated class where the scopes are defined, so that your controller will be skinny.
* To override default mapping behavior you don't need to pass a block - just define a method with the same name as scope.
* You can DRY your custom scopes mapping logic by using helper methods defined in scopie class and use the same scopie class in multiple controllers.

Imagine the following model called graduations:

```ruby
class Graduation < ActiveRecord::Base

  scope :featured, -> { where(featured: true) }
  scope :by_degree, -> (degree) { where(degree: degree) }
  scope :by_period, -> (started_at, ended_at) { where('started_at = ? AND ended_at = ?', started_at, ended_at) }

  scope :created_at_greater_than, ->(date) { where('created_at >= ?', date.beginning_of_day) }
  scope :created_at_less_than, ->(date) { where('created_at <= ?', date.end_of_day) }
  scope :updated_at_greater_than, ->(date) { where('updated_at >= ?', date.beginning_of_day) }
  scope :updated_at_less_than, ->(date) { where('updated_at <= ?', date.end_of_day) }

end
```

You can use those named scopes as filters by declaring them on your scopie:

```ruby
class GraduationsScopie < ScopieRails::Base

  has_scope :featured, type: :boolean
  has_scope :by_degree, type: :integer
  has_scope :by_period

  has_scope :created_at_greater_than, in: :created_at, as: :start_at
  has_scope :created_at_less_than, in: :created_at, as: :end_at

  has_scope :updated_at_greater_than, in: :updated_at, as: :start_at, type: :date
  has_scope :updated_at_less_than, in: :updated_at, as: :end_at, type: :date

  has_scope :page, default: 1
  has_scope :per, default: 30

  def by_period(scope, value, _hash)
    started_at = value[:started_at]
    ended_at = value[:ended_at]

    started_at && ended_at && scope.by_period(started_at, ended_at)
  end

  def created_at_greater_than(scope, value, _hash)
    scope.created_at_greater_than(parse_date(value))
  end

  def created_at_less_than(scope, value, _hash)
    scope.created_at_less_than(parse_date(value))
  end

  def updated_at_greater_than(scope, value, _hash)
    scope.updated_at_greater_than(value)
  end

  def updated_at_less_than(scope, value, _hash)
    scope.updated_at_less_than(value)
  end

  private

  def parse_date(value)
    Date.parse(value)
  end

end
```

Now, if you want to apply them to an specific resource, you just need to call `apply_scopes`:

```ruby
class GraduationsController < ApplicationController
  include ScopieRails::Controller

  def index
    @graduations = apply_scopes(Graduation).all
  end
end
```

Then for each request:

```
/graduations
#=> acts like a normal request

/graduations?featured=true
#=> calls the named scope and bring featured graduations

/graduations?by_period[started_at]=20100701&by_period[ended_at]=20101013
#=> brings graduations in the given period

/graduations?created_at[start_at]=2016-06-01&created_at[end_at]=2016-06-02
#=> brings graduations created in the given period

/graduations?featured=true&by_degree=phd
#=> brings featured graduations with phd degree
```

## Installation

Add `scopie_rails` to your Gemfile or install it from Rubygems.

```ruby
gem 'scopie_rails'
```

## Options

Scopie supports several options:

* `:type` - Coerces the type of the parameter sent. Available options: boolean, integer, float, date.

* `:only` - In which actions the scope is applied.

* `:except` - In which actions the scope is not applied.

* `:as` - The key in the params hash expected to find the scope. Defaults to the scope name.

* `:in` - The key in the params hash expected to contain a hash holding scope name as a value.

* `:allow_blank` - Blank values are not sent to scopes by default. Set to true to overwrite.

* `:default` - Default value for the scope. Whenever supplied the scope is always called.

## Rails

ScopieRails provides Rails integration for [Scopie][s].

Among other things it adds a 'controller' method to scopies.

## Thanks

Scopie was inspired by [has_scope](http://github.com/plataformatec/has_scope) and [pundit](http://github.com/elabs/pubdit).

Thanks to both.

[s]: https://github.com/beorc/scopie
