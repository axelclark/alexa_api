defmodule AlexaJSON.RequestElement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :type, :string
    field :requestId, :string
    field :locale, :string
    field :timestamp, :utc_datetime
    embeds_one :intent, AlexaJSON.Intent
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:type, :requestId, :locale, :timestamp])
    |> cast_embed(:intent)
  end
end
