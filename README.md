rubygems-source ![travis-ci](https://secure.travis-ci.org/textgoeshere/rubygems-source.png)
===============

`rubygems-source` is a remote source server for Rubygems that implements the
core Rubygems gem source web API.

Use it to host private or local dev gem servers.

Usage
-----

### Start a server ###

...or with a `config.ru` like so (from `config.ru.example`):

    require "rubygems"
    require "rubygems-source"

    Rubygems::Source::App.public_folder = "/var/rubygems-source/gems" # or wherever
    run Rubygems::Source::App

And rack up the `config.ru` with `passenger`, `thin`, `unicorn` etc.

Ensure your `gems` directory is writeable by the user your server runs
as.

### Client ###

#### Bundler ####

If you use Bundler, add your new source server to the top of your `Gemfile`s:

    source "http://gems.example.com"

#### Rubygems-wide ####

To make the new source server available to your entire Rubygems installation:

    $ gem sources --add http://gems.example.com

If you are using `RVM` or `ruby-env`, you must repeat this step for
each Rubygems installation.

You can also add the new source to your `.gemrc`s directly:

    :sources:
    - http://rubygems.org/
    - http://gems.example.com # add this line

You can now find and install gems from the new source server.

    $ gem list
    $ gem install mygem

You can also push gems to the server. **Be sure to specify the host**.

    $ gem push pkg/mygem-0.0.2.gem --host http://gems.example.com     

Requirements
------------

* Rubygems

Install
-------

* `gem install rubygems-source`

or add it to your `Gemfile`:

* `gem "rubygems-source"`

Development
-----------

* Source hosted at [GitHub](https://github.com/kapoq/rubygems-source)
* Report issues/Questions/Feature requests on [GitHub Issues](https://github.com/kapoq/rubygems-source)
* CI at [Travis](http://travis-ci.org/#!/textgoeshere/rubygems-source)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change
you make.

### Roadmap ###

* authenticate gem admin actions via API key
* implement gem dependency resolver
* show HTML list of gems/versions/links to rdoc at /
* remove Sintra dependency in favour of plain Rack for smaller footprint
* support legacy index/spec format?

### Testing ###

    $ rake

Related projects
----------------

* [rubygems-source-cli](https://github.com/kapoq/rubygems-source-cli):
  Patches to `gem push` and `gem yank` to make them work with
  non-rubygems.org sources
  [rubygems-source-features](https://github.com/kapoq/rubygems-source-features):
  Cucumber features for Rubygems sources
* [rubygems.org](https://github.com/rubygems/rubygems.org): 
  Daddy
* [geminabox](https://github.com/cwninja/geminabox): 
  Very similar project, no `gem yank`, no tests of any kind
* [sinatra-rubygems](https://github.com/jnewland/sinatra-rubygems): 
  Replacement for `gem server` - no `gem push`, `gem yank` or resolver

Author
------

[Dave Nolan](https://github.com/textgoeshere)
