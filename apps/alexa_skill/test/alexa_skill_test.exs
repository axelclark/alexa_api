defmodule AlexaSkillTest do
  use ExUnit.Case
  doctest AlexaSkill

  describe "handle_request/1" do
    test "returns response to MyColorIsIntent" do
      request =
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

      result = AlexaSkill.handle_request(request)

      assert result.response.outputSpeech.text ==
        "I now know your favorite color is red.  You can ask me your favorite color by saying, what's my favorite color?"
    end
  end
end
