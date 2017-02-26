defmodule AlexaJSON.Image do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
      field :largeImageUrl, :string
      field :smallImageUrl, :string
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:smallImageUrl, :largeImageUrl])
  end
end
