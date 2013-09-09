defmodule VerbalExpressionsTest do
  use ExUnit.Case
  alias VerbalExpressions, as: VE
  doctest VerbalExpressions

  test "record" do
    v = VerbalExpressionRecord.new

    assert v.startOfLine().then("xyz").match?("xyz")
    assert !v.startOfLine().then("xyz").match?("zyx")
    assert v.find(".").replace("Hello World.", "!") == "Hello World!"
  end

  test "concatenation" do
    assert "^(?:x)(?:x)?$" == VE.startOfLine() 
                              |> VE.then("x") 
                              |> VE.maybe("x") 
                              |> VE.endOfLine()
  end

  test "matching" do
    assert VE.startOfLine() 
           |> VE.then("x") 
           |> VE.maybe("y") 
           |> VE.match?("xy")

    assert !(VE.then("x") |> VE.match?("y"))
  end

  test "replacing" do
    assert VE.find("a") |> VE.replace("abcd", "") == "bcd"
  end
end
