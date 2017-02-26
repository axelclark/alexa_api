defmodule AlexaJSON.OutputSpeech do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
      field :type, :string
      field :text, :string
      field :ssml, :string
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:type, :text, :ssml])
  end
end
