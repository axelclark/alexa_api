defmodule AlexaJSON.Reprompt do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_one :outputSpeech, AlexaJSON.OutputSpeech
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [])
    |> cast_embed(:outputSpeech)
  end
end
