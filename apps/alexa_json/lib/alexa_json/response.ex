defmodule AlexaJSON.Response do
  use Ecto.Schema
  import Ecto.Changeset
  alias AlexaJSON.ResponseElement

  @primary_key false
  embedded_schema do
    field :version, :string, default: ""
    field :sessionAttributes, :map, default: %{}
    embeds_one :response, ResponseElement
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:version, :sessionAttributes])
    |> cast_embed(:response)
  end
end
