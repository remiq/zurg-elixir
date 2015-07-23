defmodule Zurg.Group do

  def cand([], acc) do
    acc
  end

  def cand([h|t], acc) when length(t) < 1 do
    acc
  end

  def cand([h|t], acc \\ []) do
    cand(t, List.foldl(t, [], fn (x, acc2) -> [[h, x]|acc2] end) ++ [[h]] ++ acc)
  end

end
