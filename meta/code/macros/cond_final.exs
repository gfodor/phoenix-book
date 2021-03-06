#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule ControlFlow do

  defmacro cond(do: conditions) do
    clauses = Enum.map conditions, fn {:->, _, [[expr], block]} ->
      {
        quote(do: fn -> unquote(expr) end),
        quote(do: fn -> unquote(block) end)
      }
    end

    quote bind_quoted: [clauses: clauses] do                      
      {_, func} = Enum.find clauses, fn {expr, _} -> expr.() end
      func.()
    end                                                           
  end
end

