# envy

Envy is a shard that loads environment variables from a `.env` files into `ENV`.

[![Travis](https://img.shields.io/travis/petoem/envy.svg?style=flat-square)](https://travis-ci.org/petoem/envy)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/petoem/envy/blob/master/LICENSE)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  envy:
    github: petoem/envy
```

## Usage

```crystal
# As early as possible in your application, require and load a `.env` file
require "envy"

# Load environment variables from `.env` file in the current working directory
Envy.load

# This will load environment variables and overwrite existing ones
Envy.load!

# You can specify multiple files and they will be loaded in order.
Envy.load ".env.development", ".env.redis"

# To parse a `.env` file, returns `Hash(String, String)`. Raises if the file does not exist.
Envy.parse ".env"

# To raise an exception if the .env file does not exist, you can append a block to Envy#load or Envy#load!.
Envy.load! do
  { raise_exception: true }
end
```

## `.env` files

```shell
# Comments and empty lines are ignored

# Basic environment variable
NAME=value

# You can add export in front of each line so you can source the file
export NAME=value

# Spaces inside values are kept
SPACES=are kept

# Double quotes are removed from beginning and end but kept in the inside
# e.g. QUOTES => here are \"\" inside
QUOTES="here are "" inside"

# Equal signs are allowd inside values
EQUAL_SIGNS=are=allowed=

# Variable names are automatically upcased
# e.g. NaMe => NAME
NaMe=value

# Empty value become empty string
EMPTY=
```

## Contributing

1. Fork it ( https://github.com/petoem/envy/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [petoem](https://github.com/petoem) Michael Petö - creator, maintainer
