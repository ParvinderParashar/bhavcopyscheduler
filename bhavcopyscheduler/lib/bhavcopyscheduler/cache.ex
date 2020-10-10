defmodule Bhavcopyscheduler.Cache do
  @moduledoc """
    Module utilizes cachex lib to manage cache.
    Caching helper method are included in this module for CRUD operations
  """

  use Nebulex.Cache,
    otp_app: :bhavcopyscheduler,
    adapter: Nebulex.Adapters.Dist

  defmodule Local do
    @moduledoc false

    use Nebulex.Cache,
      otp_app: :bhavcopyscheduler,
      adapter: Nebulex.Adapters.Local
  end

  defmodule JumpingHashSlot do
    @moduledoc false

    @behaviour Nebulex.Adapter.HashSlot

    @doc """
    This function uses [Jump Consistent Hash](https://github.com/cabol/jchash).
    """
    @impl true
    def keyslot(key, range) do
      key
      |> :erlang.phash2()
      |> :jchash.compute(range)
    end
  end

  @spec set_with_default_ttl(Nebulex.Cache.key(), Nebulex.Cache.value()) :: Nebulex.Cache.value()
  def set_with_default_ttl(key, value) do
    set(key, value, ttl: MC.user_session_ttl_sec())
  end
