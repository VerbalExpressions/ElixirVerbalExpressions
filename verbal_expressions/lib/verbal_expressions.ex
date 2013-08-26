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
  """

  @doc """
  Match a given string with a given regex string.

  ## Examples
      iex> VE.find("@") |> VE.match?("some@email.com")
      true

  """
  def match?(regex, string) do
    Regex.match?(Regex.compile!(regex), string)
  end

  @doc """
  Replace the occurences of regex in the given string with the given replacement
  text.
  
  ## Examples
      iex> VE.find("x") |> VE.replace("xyz", "")
      "yz"
 
  """
  def replace(regex, string, replacement) do
    Regex.compile!(regex) |> Regex.replace string, replacement
  end

  @doc """
  Express the start of a line regex anchor. This translates to '^'.
  """
  def startOfLine() do
    "^"
  end

  @doc """
  Express the end of a line regex anchor. This translates to '$'.
  """
  def endOfLine() do
    "$"
  end

  @doc "Concatenation version of endOfLine/0."
  def endOfLine(before) do
    before <> endOfLine()
  end

  @doc """
  Express an exact string match.

  ## Examples

      iex> VE.then("x") |> VE.match?("x")
      true

      iex> VE.then("hello") |> VE.match?("holla")
      false

  """
  def then(string) do
    "(?:" <> Regex.escape(string) <> ")"
  end

  @doc "Concatenation version of then/1"
  def then(before, string) do
    before <> then(string)
  end

  @doc """
  See then/1. Defined for API compatibility with the Javascript version. The
  Elixir matching can be started with then/1, as well.  
  """
  def find(string) do
    then(string)
  end

  @doc """
  Express an optional string match. This translates to (string)?.

  ## Examples

      iex> VE.find("12") |> VE.maybe("h") |> VE.maybe("m") |> VE.match?("12h")
      true

  """
  def maybe(string) do
    "(?:" <> Regex.escape(string) <> ")?"
  end

  @doc "Concatenation version of maybe/1"
  def maybe(before, string) do
    before <> maybe(string)
  end

  @doc """
  Match any number of any characters. Translates to '.*'.

  ## Examples
  
      iex> VE.anything() |> VE.then("hours") |> VE.match?("12 hours")
      true

      iex> VE.anything() |> VE.then("hours") |> VE.match?("24 hours")
      true

      iex> VE.anything() |> VE.then("hours") |> VE.match?("10 minutes")
      false

  """
  def anything() do
    "(?:.*)"
  end


  @doc "Concatenation version of anything/0"
  def anything(before) do
    before <> anything()
  end

  @doc """
  Match anything but the given string. Translates to "[^string]*".

  ## Examples

      iex> VE.anythingBut("www.google.com") |> VE.match?("www.elixir-lang.org")
      true

      iex> VE.find("W") |> VE.anythingBut("O") |> VE.then("W") |> VE.match?("WOW")
      false
  """
  def anythingBut(string) do
    "(?:[^" <> Regex.escape(string) <> "]*)"
  end

  @doc "Concatenation version of anythingBut/1"
  def anythingBut(before, string) do
    before <> anythingBut(string)
  end

  @doc """
  Match any string but the empty one. Translates to ".+".

  ## Examples

      iex> VE.something() |> VE.match?("")
      false

      iex> VE.something() |> VE.match?("foo")
      true

  """
  def something() do
    "(?:.+)"
  end

  @doc "Concatenation version of something/0"
  def something(before) do
    before <> something()
  end

  @doc """
  Match anything except the given string and the empty string. Translates to
  "[^string]+".

  ## Examples
 
      iex> VE.somethingBut("www.") |> VE.match?("ftp.google.com")
      true

      iex> VE.startOfLine() |> VE.somethingBut("www.") |> VE.match?("www.google.com")
      false

  """
  def somethingBut(string) do
    "(?:[^" <> Regex.escape(string) <> "]+)"
  end

  @doc "Concatenation version of somethingBut/1"
  def somethingBut(before, string) do
    before <> somethingBut(string)
  end
end


defrecord VerEx, regex: "" do
  @docmodule """
  Verbal Expressions as Records, to allow chaining of function calls.

  Verbal Expressions can also be used with records, which add a syntax very much
  like the Javascript original. Records allow you to chain function calls,
  instead of using the |> operator. See the following examples to get the idea.

  ### Examples

      iex>v = VerEx.new
      iex>v.startOfLine().then("hello").match?("world")
      false

  """

  def match?(string, record) do
    Regex.match?(Regex.compile!(record.regex), string)
  end

  def replace(string, replacement, record) do
    Regex.compile!(record.regex) |> Regex.replace(string, replacement)
  end
  
  def startOfLine(record) do
    record.update_regex fn _ -> "^" end
  end
  
  def endOfLine(record) do
    record.update_regex fn before -> before <> "$" end
  end
  
  def then(string, record) do
    record.update_regex fn before -> 
      before <> "(?:" <> Regex.escape(string) <> ")"
    end
  end
    
  def find(string, record) do
    then(string, record)
  end

  def maybe(string, record) do
    record.update_regex fn before ->
      before <> "(?:" <> Regex.escape(string) <> ")?"
    end
  end

  def anything(record) do
    record.update_regex fn before -> before <> "(?:.*)" end
  end

  def anythingBut(string, record) do
    record.update_regex fn before -> 
      before <> "?:[^" <> Regex.escape(string) <> "]*)"
    end
  end

  def something(record) do
    record.update_regex fn before -> before <> "(?:.+)" end
  end

  def somethingBut(string, record) do
    record.update_regex fn before ->
      before <> "(?:[^" <> Regex.escape(string) <> "]+"
    end
  end
end
