defmodule VerbalExpressionsExamplesTest do
  use ExUnit.Case
  alias VerbalExpressions, as: VerEx

  @moduledoc """
  Testcases for the examples shown in the readme file. Directly ported from the
  Jacascript version.
  """

  test "valid url" do
    # Create an example of how to test for correctly formed URLs
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

    assert result 
  end

  test "replacing strings" do
    # Create a test string
    replaceMe = "Replace bird with a duck"

    # Create an expression that seeks for word "bird"
    expression = VerEx.find "bird"

    # Execute the expression like a normal RegExp object
    result = expression |> VerEx.replace replaceMe, "duck"

    IO.puts result # Outputs "Replace duck with a duck"

    assert result == "Replace duck with a duck"
  end

  test "replacing strings shorthand" do
    result = VerEx.find("red") |> VerEx.replace "We have a red house", "blue"
             
    IO.puts result # Outputs "We have a blue house"
    
    assert result == "We have a blue house"
  end
end
