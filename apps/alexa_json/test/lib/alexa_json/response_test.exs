defmodule AlexaJSON.ResponseTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.{Request, RequestElement, Intent, Session, User, Application,
                   Response, ResponseElement, Card, Image, OutputSpeech, Reprompt}

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
      request = %Request{request:
        %RequestElement{intent:
          %Intent{name: "alexa skill",
            slots: %{"slot" => %{"name" => "value"}}
          }, locale: "en-US", requestId: "request123",
          timestamp: %DateTime{calendar: Calendar.ISO, day: 22, hour: 2,
            microsecond: {0, 0}, minute: 40, month: 2, second: 44, std_offset: 0,
            time_zone: "Etc/UTC", utc_offset: 0, year: 2017, zone_abbr: "UTC"
          },
          type: "IntentRequest"
        },
        session: %Session{application:
          %Application{applicationId: "application123"},
          attributes: %{"attr" => %{"key" => "value"}}, new: true,
          sessionId: "session123", user: %User{userId: "user123"}
        },
        version: "1.0"
      }

      result = AlexaJSON.Response.create_from_request(request)

      assert result.sessionAttributes == %{"attr" => %{"key" => "value"}}
      assert result.version == "1.0"
    end
  end
end
