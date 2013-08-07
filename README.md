ElixirVerbalExpressions
=======================

Elixir Regular Expressions made easy. Ported from the JavaScript version [VerbalExpressions](https://github.com/jehna/VerbalExpressions).

[![Build Status](https://travis-ci.org/maxsz/ElixirVerbalExpressions.png)](https://travis-ci.org/maxsz/ElixirVerbalExpressions)

## How to get started

You cannot get started, yet. Step-by-step introductions will be presented here,
once ready.

## Examples

Here's a couple of simple examples to give an idea of how VerbalExpressions works:

### Testing if we have a valid URL

```elixir
# Create an example of how to test for correctly formed URLs
alias VerbalExpressions, as: VE
tester = VE.startOfLine()
         |> VE.then("http")
         |> VE.maybe("s")
         |> VE.then("://")
         |> VE.maybe("www")
         |> VE.anythingBut(" ")
         |> VE.endOfLine()
         
testMe = "https://www.google.com"

result = tester |> VE.match?(testMe)

if result do
  IO.puts "Valid URL :)"
else
  IO.puts "Invalid URL :("
end

```

## API documentation

You can find the API documentation on it's (own page)[http://maxsz.github.io/ElixirVerbalExpressions/docs/index.html].

## Contributions
Pull requests are welcome.

## Issues
 - Nothing's working, yet :)

## Thanks
Thank you to @jehna for coming up with the awesome original idea!

