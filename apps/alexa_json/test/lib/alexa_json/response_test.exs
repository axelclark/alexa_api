defmodule AlexaJSON.ResponseTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.{Request, Session, Response, ResponseElement, Card, Image,
                   OutputSpeech, Reprompt}

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

  describe "changeset/2" do
    test "changeset casts only valid attributes" do
      attrs = Map.merge(@valid_attrs, @invalid_attrs)
      response_struct =
        %Response{
          response: %ResponseElement{
            card: %Card{content: "string",
              image: %Image{
                largeImageUrl: "string", smallImageUrl: "string"
              }, text: "string", title: "string", type: "string"
            },
            outputSpeech: %OutputSpeech{
              ssml: "hiyo", text: "hi", type: "text"
            },
            reprompt: %Reprompt{
              outputSpeech: %OutputSpeech{
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

  describe "create_from_request/2" do
    test "creates changeset from request" do
      request = %Request{
        session: %Session{
          attributes: %{"attr" => %{"key" => "value"}}
        },
        version: "1.0"
      }

      result = AlexaJSON.Response.create_from_request(request)

      assert result.sessionAttributes == %{"attr" => %{"key" => "value"}}
      assert result.version == "1.0"
    end
  end

  describe "update_response/2" do
    test "update response struct" do
      request = %Request{
        session: %Session{
          attributes: %{"attr" => %{"key" => "value"}}
        },
        version: "1.0"
      }
      response = AlexaJSON.Response.create_from_request(request)
      outputSpeech =
        %{response: %{outputSpeech: %{type: "plainText", text: "hi"}}}

      result = AlexaJSON.Response.update_response(response, outputSpeech)

      assert result.response.outputSpeech.text == "hi"
    end
  end
end
