# Hashids.jl

A Julia port of the JavaScript Hashids implementation. Website: http://www.hashids.org/

## Installation

To install, run on the Julia Pkg REPL-mode:

```julia
pkg> add https://github.com/antimon2/Hashids.jl.git
```

Then you can run the built-in unit tests with

```julia
pkg> test Hashids
```

to verify that everything is functioning properly on your machine.


## Usage

Import the `Hashids` module:

```julia
julia> import Hashids
```

### Basic Usage

Configure (with default parameters):

```julia
julia> conf = Hashids.configure();
```

Encode a single integer:

```julia
julia> Hashids.encode(conf, 123)
"Mj3"
```

Decode a hash (returns 1-element Integer Array):

```julia
julia> Hashids.decode(conf, "xoz")
1-element Array{Int64,1}:
 456
```

Encode deveral integers:

```julia
julia> Hashids.encode(conf, 123, 456, 789)
"El3fkRIo3"

julia> Hashids.encode(conf, [123, 456, 789])
"El3fkRIo3"

```

Decode the hash (returns N-element Integer Array):

```julia
julia> Hashids.decode(conf, "1B8UvJfXm")
3-element Array{Int64,1}:
 517
 729
 185
```

### Using Custom Salt

Hashids supports salting hashes by accepting a salt value. If you don’t want others to decode your hashes, provide a unique string to the configurator.

```julia
julia> conf = Hashids.configure(salt="this is my salt 1");

julia> Hashids.encode(conf, 123)
"nVB"
```

The generated hash changes whenever the salt is changed:

```julia
julia> conf = Hashids.configure("this is my salt 2");  # equivalent to `Hashids.configure(salt="this is my salt 2")`

julia> Hashids.encode(conf, 123)
"ojK"
```

A salt string between 6 and 32 characters provides decent randomization.

### Controlling Hash Length

By default, hashes are going to be the shortest possible. One reason you might want to increase the hash length is to obfuscate how large the integer behind the hash is.

This is done by passing the minimum hash length to the configurator. Hashes are padded with extra characters to make them seem longer.

```julia
julia> conf = Hashids.configure(min_length=16);

julia> Hashids.encode(conf, 1)
"4q2VolejRejNmGQB"
```

### Using A Custom Alphabet

It’s possible to set a custom alphabet for your hashes. The default alphabet is "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".

To have only lowercase letters in your hashes, pass in the following custom alphabet:

```julia
julia> conf = Hashids.configure(alphabet="abcdefghijklmnopqrstuvwxyz");

julia> Hashids.encode(conf, 123456789)
"kekmyzyk"
```

A custom alphabet must contain at least 16 characters.

## Randomness

The primary purpose of hashids is to obfuscate ids. It's not meant or tested to be used for security purposes or compression. Having said that, this algorithm does try to make these hashes unguessable and unpredictable:

### Repeating numbers

There are no repeating patterns that might show that there are 4 identical numbers in the hash:

```julia
julia> conf = Hashids.configure("this is my salt");

julia> Hashids.encode(conf, 5, 5, 5, 5)
"1Wc8cwcE"
```

The same is valid for incremented numbers:

```julia
julia> Hashids.encode(conf, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
"kRHnurhptKcjIDTWC3sx"

julia> Hashids.encode(conf, 1)
"NV"

julia> Hashids.encode(conf, 2)
"6m"

julia> Hashids.encode(conf, 3)
"yD"

julia> Hashids.encode(conf, 4)
"2l"

julia> Hashids.encode(conf, 5)
"rD"
```

## Curses! \#$%@

This code was written with the intent of placing generated hashes in visible places – like the URL. Which makes it unfortunate if generated hashes accidentally formed a bad word.

Therefore, the algorithm tries to avoid generating most common English curse words by never placing the following letters next to each other: **c, C, s, S, f, F, h, H, u, U, i, I, t, T**.

## License

MIT license, see the LICENSE file. You can use hashids in open source projects and commercial products.
