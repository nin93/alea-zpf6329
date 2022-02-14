# Alea ZPF6329

 This is an [alea](https://github.com/nin93/alea) extension that brings the
 `ZPF6329` pseudo random number genererator.

 This was derived from alea's `XSR128` engine applying arbitrary modifications
 just for the fun of it and is not meant to be a proper generator, even if it
 has passed specs.

## Installation

1. Add the dependency to your `shard.yml` along with `alea`:

```yaml
dependencies:
  alea:
    github: nin93/alea
  alea-zpf6329:
    github: nin93/alea-zpf6329
```

2. Run `shards install`

## Usage

Import the library:

```crystal
require "alea"
require "alea-zpf6329"

# Use `Alea::ZPF6329` as engine for `Alea::Random`:
random = Alea::Random(Alea::ZPF6329).new
random.normal # => 0.3318250638597536
```

## Contributing

1. Fork it (<https://github.com/nin93/alea-zpf6329/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Elia Franzella](https://github.com/nin93) - creator and maintainer
