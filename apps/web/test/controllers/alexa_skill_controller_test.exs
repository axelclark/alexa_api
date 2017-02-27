defmodule Web.AlexaSkillControllerTest do
  use Web.ConnCase

  describe "create/2" do
    test "returns JSON response" do
      conn = build_conn()
      params =
      %{
        "request" => %{
          "inDialog" => false, "intent" => %{"name" => "HiNana"},
          "locale" => "en-US", "requestId" => "request123",
          "timestamp" => "2017-02-26T23:51:20Z", "type" => "IntentRequest"
        },
        "session" => %{"application" => %{"applicationId" => "appId123"},
          "attributes" => %{}, "new" => false, "sessionId" => "session123",
          "user" => %{"userId" => "user123"}
        },
        "version" => "1.0"
      }

      conn = post conn, alexa_skill_path(conn, :create, params)

      assert json_response(conn, 200) ==
        %{"response" => %{
            "card" => nil,
            "outputSpeech" => %{
              "ssml" => "", "text" => "hi, Nana", "type" => "PlainText"
            },
            "reprompt" => nil,
            "shouldEndSession" => true
          },
          "sessionAttributes" => %{},
          "version" => "1.0"
        }
    end
  end
end
