defmodule AlexaJSON.ResponseElementTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.ResponseElement

  @valid_attrs %{
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
  }

  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)
    reprompt_struct =
      %AlexaJSON.ResponseElement{
        card: %AlexaJSON.Card{content: "string",
          image: %AlexaJSON.Image{
            largeImageUrl: "string", smallImageUrl: "string"
          },
          text: "string", title: "string",type: "string"
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
      }

    changeset = ResponseElement.changeset(%ResponseElement{}, attrs)
    result = apply_changes(changeset)

    assert get_change(changeset, :test) == nil
    assert result == reprompt_struct
  end
end
