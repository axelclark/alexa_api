defmodule AlexaJSON.RequestElement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :type, :string, default: ""
    field :requestId, :string, default: ""
    field :locale, :string, default: ""
    field :inDialog, :boolean, default: false
    field :timestamp, :utc_datetime, default: nil
    embeds_one :intent, AlexaJSON.Intent, on_replace: :update
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:type, :requestId, :locale, :timestamp, :inDialog])
    |> cast_embed(:intent)
  end
end
