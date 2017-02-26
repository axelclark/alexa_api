defmodule AlexaJSON.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :new, :boolean, default: true
    field :sessionId, :string, default: ""
    field :attributes, :map, default: %{}
    embeds_one :user, AlexaJSON.User
    embeds_one :application, AlexaJSON.Application
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:new, :sessionId, :attributes])
    |> cast_embed(:user)
    |> cast_embed(:application)
  end
end
