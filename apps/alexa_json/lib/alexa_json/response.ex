defmodule AlexaJSON.Response do
  use Ecto.Schema
  import Ecto.Changeset
  alias AlexaJSON.{ResponseElement, Response, Card, Image, OutputSpeech, Reprompt}

  @primary_key false
  embedded_schema do
    field :version, :string, default: ""
    field :sessionAttributes, :map, default: %{}
    embeds_one :response, ResponseElement, on_replace: :update
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:version, :sessionAttributes])
    |> cast_embed(:response)
  end

  def create_from_request(request) do
    request_data =
      %{
        sessionAttributes: request.session.attributes,
        version: request.version
      }

    response =
      %Response{
        response: %ResponseElement{
          card: %Card{image: %Image{}},
          outputSpeech: %OutputSpeech{},
          reprompt: %Reprompt{
            outputSpeech: %OutputSpeech{}
          }
        }
      }

    response
    |> Response.changeset(request_data)
    |> apply_changes
  end

  def update_response(response, changes) do
    response
    |> Response.changeset(changes)
    |> apply_changes
  end
end
