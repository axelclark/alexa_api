defmodule AlexaJSON.Response do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :version, :string
    field :sessionAttributes, :map
    embeds_one :response, AlexaJSON.ResponseElement
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:version, :sessionAttributes])
    |> cast_embed(:response)
  end
end
