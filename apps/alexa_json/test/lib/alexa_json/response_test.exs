defmodule AlexaJSON.ResponseTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.Response

  @valid_attrs %{
    "response" => %{
      "card" => %{
        "type" => "string",
        "title" => "string",
        "content" => "string",
        "text" => "string",
        "image" => %{
          "smallImageUrl" => "string",
          "largeImageUrl" => "string"
        }
      },
      "reprompt" => %{
        "outputSpeech" => %{
          "type" => "text", "text" => "hi", "ssml" => "hiyo"
        }
      },
      "outputSpeech" => %{
        "type" => "text", "text" => "hi", "ssml" => "hiyo"
      },
      "shouldEndSession" => true
    },
    "version" => "string",
    "sessionAttributes" => %{
      "string" => %{
        "string" => "string"
      }
    }
  }
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)
    response_struct =
      %AlexaJSON.Response{
        response: %AlexaJSON.ResponseElement{
          card: %AlexaJSON.Card{content: "string",
            image: %AlexaJSON.Image{
              largeImageUrl: "string", smallImageUrl: "string"
            }, text: "string", title: "string", type: "string"
          },
          outputSpeech: %AlexaJSON.OutputSpeech{
            ssml: "hiyo", text: "hi", type: "text"
          },
          reprompt: %AlexaJSON.Reprompt{
            outputSpeech: %AlexaJSON.OutputSpeech{
              ssml: "hiyo", text: "hi", type: "text"
            }
          },
          shouldEndSession: true
        },
        sessionAttributes: %{"string" => %{"string" => "string"}},
        version: "string"
      }

    changeset = Response.changeset(%Response{}, attrs)
    result = apply_changes(changeset)

    assert result == response_struct
  end
end
