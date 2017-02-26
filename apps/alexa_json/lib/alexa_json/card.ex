defmodule AlexaJSON.Card do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :type, :string
    field :title, :string
    field :content, :string
    field :text, :string
    embeds_one :image, AlexaJSON.Image
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:type, :title, :content, :text])
    |> cast_embed(:image)
  end
end
