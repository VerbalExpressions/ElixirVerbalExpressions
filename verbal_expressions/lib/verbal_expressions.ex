defmodule VerbalExpressions do
  @moduledoc """
  Use VerbalExpressions, as the name suggests, to express Regular Expressions in
  a more verbal way. Instead of a rather cryptic regular expressions like:

      iex>Regex.match?(%r/^te?.*s.+$/, "test")
      true

  you can use VerbalExpressions to write:

      iex> VerbalExpressions.startOfLine() 
      iex> |> VerbalExpressions.then("t") 
      iex> |> VerbalExpressions.maybe("e") 
      iex> |> VerbalExpressions.anything() 
      iex> |> VerbalExpressions.then("s") 
      iex> |> VerbalExpressions.something()
      iex> |> VerbalExpressions.endOfLine()
      iex> |> VerbalExpressions.match?("test")
      true


  ## Record syntax

  Verbal Expressions can also be used with records, which add a syntax very much
  like the Javascript original. Records allow you to chain function calls,
  instead of using the |> operator. See the following examples to get the idea.

  ### Examples

      iex>v = VerEx.new
      iex>v.startOfLine().then("hello").match("world")
      false

  """

  @doc """
  Verbal Expressions as Records, to allow chaining of function calls.
  """
  defrecord VerEx, regex: "" do

    def startOfLine(record) do
      record.update_regex fn _ -> "^" end
    end

    def endOfLine(record) do
      record.update_regex fn old -> old <> "$" end
    end
    
    def then(s, record) do
      record.update_regex fn old -> old <> Regex.escape(s) end
    end
    
    def match(s, record) do
      Regex.match?(Regex.compile!(record.regex), s)
    end
  end

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

  def anything(before) do
    before <> anything()
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

  def something(before) do
    before <> something()
  end

  def somethingBut(string) do
    "(?:[^" <> Regex.escape(string) <> "]+"
  end

  def somethingBut(before, string) do
    before <> somethingBut(string)
  end

end
