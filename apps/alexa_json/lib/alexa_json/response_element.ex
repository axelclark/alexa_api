defmodule AlexaJSON.ResponseElement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :shouldEndSession, :boolean, default: true
    embeds_one :outputSpeech, AlexaJSON.OutputSpeech, on_replace: :update
    embeds_one :reprompt, AlexaJSON.Reprompt, on_replace: :update
    embeds_one :card, AlexaJSON.Card, on_replace: :update

  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:shouldEndSession])
    |> cast_embed(:outputSpeech)
    |> cast_embed(:reprompt)
    |> cast_embed(:card)
  end
end
