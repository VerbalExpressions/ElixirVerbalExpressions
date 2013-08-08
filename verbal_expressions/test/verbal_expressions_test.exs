defmodule VerbalExpressionsTest do
  use ExUnit.Case
  alias VerbalExpressions, as: VE
  doctest VerbalExpressions

  test "record" do
    ve = VerEx.new
    assert ve.startOfLine().then("xyz").match("xyz")
    assert !ve.startOfLine().then("xyz").match("zyx")
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
end
