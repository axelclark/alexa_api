defmodule AlexaJSON.ResponseElement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :shouldEndSession, :boolean
    embeds_one :outputSpeech, AlexaJSON.OutputSpeech
    embeds_one :reprompt, AlexaJSON.Reprompt
    embeds_one :card, AlexaJSON.Card

  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:shouldEndSession])
    |> cast_embed(:outputSpeech)
    |> cast_embed(:reprompt)
    |> cast_embed(:card)
  end
end
