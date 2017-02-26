defmodule AlexaJSON.Card do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :type, :string, default: ""
    field :title, :string, default: ""
    field :content, :string, default: ""
    field :text, :string, default: ""
    embeds_one :image, AlexaJSON.Image
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:type, :title, :content, :text])
    |> cast_embed(:image)
  end
end
