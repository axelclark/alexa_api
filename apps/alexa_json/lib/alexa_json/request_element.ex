defmodule AlexaJSON.RequestElement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :type, :string, default: ""
    field :requestId, :string, default: ""
    field :locale, :string, default: ""
    field :timestamp, :utc_datetime, default: nil
    embeds_one :intent, AlexaJSON.Intent
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:type, :requestId, :locale, :timestamp])
    |> cast_embed(:intent)
  end
end
