defmodule Web.AlexaSkillControllerTest do
  use Web.ConnCase

  describe "create/2" do
    test "returns JSON response" do
      conn = build_conn()
      params =
        %{
          "request" => %{
            "inDialog" => false,
            "intent" => %{
              "name"=> "MyColorIsIntent",
              "slots"=> %{
                "Color"=> %{
                  "name"=> "Color",
                  "value"=> "red"
                }
              }
            },
            "locale" => "en-US", "requestId" => "request123",
            "timestamp" => "2017-02-26T23=>51=>20Z", "type" => "IntentRequest"
          },
          "session" => %{"application" => %{"applicationId" => "appId123"},
            "attributes" => %{}, "new" => true, "sessionId" => "session123",
            "user" => %{"userId" => "user123"}
          },
          "version" => "1.0"
        }

      conn = post conn, alexa_skill_path(conn, :create, params)

      assert json_response(conn, 200) ==
        %{
          "version"=> "1.0",
          "response"=> %{
            "outputSpeech"=> %{
              "type"=> "PlainText",
              "text"=> "I now know your favorite color is red.  You can ask me your favorite color by saying, what's my favorite color?",
              "ssml" => ""
            },
            "card"=> %{
              "content"=> "SessionSpeechlet - I now know your favorite color is red.  You can ask me your favorite color by saying, what's my favorite color?",
              "title"=> "SessionSpeechlet - MyColorIsIntent",
              "type"=> "Simple",
              "text" => "",
              "image" => nil
            },
            "reprompt"=> %{
              "outputSpeech"=> %{
                "type"=> "PlainText",
                "text"=> "You can ask me your favorite color by saying, what's my favorite color?",
                "ssml" => ""
              }
            },
            "shouldEndSession"=> false
          },
          "sessionAttributes"=> %{
            "favoriteColor"=> "red"
          }
        }
    end
  end
end
