defmodule AlexaJSON.Request do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :version, :string
    embeds_one :request, AlexaJSON.RequestElement
    embeds_one :session, AlexaJSON.Session
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:version])
    |> cast_embed(:request)
    |> cast_embed(:session)
  end

  def from_json(data) when is_binary(data) do
    Poison.decode!(data) |> from_json
  end

  def from_json(data) when is_map(data) do
    %__MODULE__{}
    |> changeset(data)
    |> apply_changes
  end
end
