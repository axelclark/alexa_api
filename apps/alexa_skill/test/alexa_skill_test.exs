defmodule AlexaSkillTest do
  use ExUnit.Case
  doctest AlexaSkill

  describe "handle_request/1" do
    test "returns hello world" do
      request = %{
        "session" => %{
          "attributes" => %{"attr" => %{"key" => "value"}}
        },
        "version" => "1.0"
      }

      result = AlexaSkill.handle_request(request)

      assert result.response.outputSpeech.text == "hi, Nana"
    end
  end
end
