defmodule VerbalExpressionsTest do
  use ExUnit.Case
  alias VerbalExpressions, as: VE
  doctest VerbalExpressions

  test "the truth" do
    assert(true)
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
