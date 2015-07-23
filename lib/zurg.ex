defmodule Zurg do
  # Record {flashlight, on_left, on_right, history, time}
  @start {:left, [:buzz, :woody, :rex, :hamm], [], [], 0}
  @stop_time 60
  @time [buzz: 5, woody: 10, rex: 20, hamm: 25]
  

  def solve({_, _, _, _, time}) when time > @stop_time do
    []
  end

  def solve({:right, [], _, history, time}) do
    {time, history}
  end

  def solve(state \\ @start) do
    List.flatten Enum.map(next(state), fn state -> solve(state) end)
  end

  def next({:left, src, dst, hist, time}) do
    Enum.map Zurg.Group.cand(src), fn group ->
      {:right, src -- group, dst ++ group, [group|hist], time + time(group)}
    end
  end

  def next({:right, dst, src, hist, time}) do
    Enum.map Zurg.Group.cand(src), fn group ->
      {:left, dst ++ group, src -- group, [group|hist], time + time(group)}
    end
  end

  def time([person]) do
    @time[person]
  end

  def time([p1, p2]) do
    max time([p1]), time([p2])
  end


  # Ideas:
  # * Zurg.Queue to queue states to check
  # * pool of workers checking queue
  # * send messages to yourself (how much memory it takes compared with function call?)
  # * use generator to generate states
  # * use tail-call to store not tested states (seems wasteful)

end
