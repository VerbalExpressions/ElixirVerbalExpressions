ElixirVerbalExpressions
=======================

Elixir Regular Expressions made easy. Ported from the JavaScript version [VerbalExpressions](https://github.com/jehna/VerbalExpressions).

[![Build Status](https://travis-ci.org/maxsz/ElixirVerbalExpressions.png)](https://travis-ci.org/maxsz/ElixirVerbalExpressions)

## How to get started

Include the VerbalExpressions module (and alias it, if you want). Then simply check out the Examples and documentation to get started. It's easy :)

## Examples

Here's a couple of simple examples to give an idea of how VerbalExpressions works:

### Testing if we have a valid URL

```elixir
# Create an example of how to test for correctly formed URLs
alias VerbalExpressions, as: VerEx
tester = VerEx.startOfLine()
         |> VerEx.then("http")
         |> VerEx.maybe("s")
         |> VerEx.then("://")
         |> VerEx.maybe("www")
         |> VerEx.anythingBut(" ")
         |> VerEx.endOfLine()
         
testMe = "https://www.google.com"

result = tester |> VerEx.match?(testMe)

if result do
  IO.puts "Valid URL :)"
else
  IO.puts "Invalid URL :("
end

```

### Replacing strings

```elixir
# Create a test string
replaceMe = "Replace bird with a duck"

# Create an expression that seeks for word "bird"
expression = VerEx.find "bird"

# Execute the expression like a normal RegExp object
result = expression |> VerEx.replace replaceMe, "duck"

IO.puts result # Outputs "Replace duck with a duck"
```

### Shorthand for string replace:

```elixir
result = VerEx.find("red") |> VerEx.replace "We have a red house", "blue"

IO.puts result # Outputs "We have a blue house"
```

### Method chaining

The original version of VerbalExpressions uses method chaining. This version of
verbal expressions in Elixir does not only support the (nicer) `|>`-based
chaining, but also has a record-based version for method-chaining support.

Here is the above string replace example using method chaining:

```elixir
v = VerbalExpressionRecord.new
result = v.find("red").replace("We have a red house", "blue")

IO.puts result # Outputs "We have a blue house"
```

## API documentation

You can find the API documentation on it's [own page](http://maxsz.github.io/ElixirVerbalExpressions/docs/index.html).

## Contributions
Pull requests are welcome.

## Issues
Please report any issues to the GitHub issuetracker.

## Thanks
Thank you to @jehna for coming up with the awesome original idea!

