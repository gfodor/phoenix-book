defmodule TextClient.Prompter do
  alias TextClient.State

  def accept_move(game = %State{}) do
    input = IO.gets("Your guess: ")
    check_input(input, game)
  end

  defp check_input({ :error, reason }, _) do
    IO.puts("Ended: #{reason}")
    exit :normal
  end

  defp check_input(:eof, _) do
    IO.puts("You gave up")
    exit :normal
  end

  defp check_input(input, game = %State{}) do
    input = String.trim(input)

    cond do
      input =~ ~r/\A[a-z]\z/ -> 
        Map.put(game, :guess, input)
      true ->
        IO.puts("Please enter a letter")
        accept_move(game)
    end
  end
end
