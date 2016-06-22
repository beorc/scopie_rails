## ScopieRails
[Scopie][s] for Rails

ScopieRails allows you to map incoming controller parameters to named scopes in your resources and decouple mapping logic from controller.
Imagine the following model called graduations:

```ruby
class Graduation < ActiveRecord::Base
  scope :featured, -> { where(:featured => true) }
  scope :by_degree, -> degree { where(:degree => degree) }
  scope :by_period, -> started_at, ended_at { where("started_at = ? AND ended_at = ?", started_at, ended_at) }
end
```

You can use those named scopes as filters by declaring them on your scopie:

```ruby
class Scopies::GraduationsScopie < ScopieRails::Base
  has_scope :featured, type: :boolean
  has_scope :by_degree
  has_scope :by_period

  def by_period(scope, value, _hash)
    scope.by_period(value[:started_at], value[:ended_at])
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

* `:type` - Checks the type of the parameter sent.

* `:only` - In which actions the scope is applied.

* `:except` - In which actions the scope is not applied.

* `:default` - Default value for the scope. Whenever supplied the scope is always called.

## Rails

ScopieRails provides Rails integration for [Scopie][s].

Among other things it adds a 'controller' method to scopies.

## Thanks

Scopie was inspired by [has_scope](http://github.com/plataformatec/has_scope) and [pundit](http://github.com/elabs/pubdit)

Thanks to both.

[s]: https://github.com/beorc/scopie
