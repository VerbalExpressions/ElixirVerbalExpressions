defmodule VerbalExpressions do
  @moduledoc """
  Use VerbalExpressions, as the name suggests, to express Regular Expressions in
  a more verbal way. Instead of a rather cryptic regular expressions like:

      Regex.match?(%r/^te?.*s[^t]*$/, "test") 

  you can use VerbalExpressions to write:

      startOfLine() 
      |> then("t") 
      |> maybe("e") 
      |> anything() 
      |> then("s") 
      |> anythingBut("t")
      |> endOfLine()
      |> match?("test")

  """

  @doc """
  This function matches a given string with a given regex string.
  """
  def match?(regex, string) do
    Regex.match?(Regex.compile!(regex), string)
  end

  def startOfLine() do
    "^"
  end

  def endOfLine() do
    "$"
  end

  def endOfLine(before) do
    before <> endOfLine()
  end

  @doc """
  This function creates a regex string that will match the given string.

  ## Examples

      iex> VE.then("x") |> VE.match?("x")
      true

  """
  def then(string) do
    "(?:" <> Regex.escape(string) <> ")"
  end

  def then(before, string) do
    before <> then(string)
  end

  @doc """
  This is defined for API compatibility with the Javascript version. The Elixir
  matching can be started with then/1, as well.
  """
  def find(string) do
    then(string)
  end

  def maybe(string) do
    "(?:" <> Regex.escape(string) <> ")?"
  end

  def maybe(before, string) do
    before <> maybe(string)
  end

  def anything() do
    "(?:.*)"
  end

  def anythingBut(string) do
    "(?:[^" <> Regex.escape(string) <> "]*)"
  end

  def anythingBut(before, string) do
    before <> anythingBut(string)
  end

  def something() do
    "(?:.+)"
  end

  def somethingBut(string) do
    "(?:[^" <> Regex.escape(string) <> "]+"
  end

  def somethingBut(before, string) do
    before <> somethingBut(string)
  end

end
