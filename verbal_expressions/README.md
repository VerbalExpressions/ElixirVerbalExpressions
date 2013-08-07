# VerbalExpressions

Use VerbalExpressions, as the name suggests, to express Regular Expressions in a
more verbal way. Instead of a rather cryptic regular expressions like:

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

