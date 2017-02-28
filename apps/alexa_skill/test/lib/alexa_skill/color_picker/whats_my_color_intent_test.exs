defmodule AlexaSkill.ColorPicker.WhatsMyColorIntentTest do
  use ExUnit.Case

  alias AlexaSkill.ColorPicker.WhatsMyColorIntent

  describe "handle_request/2" do
    test "returns response to MyColorIsIntent" do
      request =
        %AlexaJSON.Request{
          request: %AlexaJSON.RequestElement{
            inDialog: false,
            intent: %AlexaJSON.Intent{
              name: "WhatsMYColorIntent",
              slots: %{}
            },
            locale: "en-US",
            requestId: "request123",
            timestamp: nil,
            type: "IntentRequest"
          },
          session: %AlexaJSON.Session{
            application: %AlexaJSON.Application{
              applicationId: "appId123"
            },
            attributes: %{
              "favoriteColor" => "red"
            },
            new: true,
            sessionId: "session123",
            user: %AlexaJSON.User{userId: "user123"}
          },
          version: "1.0"
        }
      response = AlexaJSON.Response.create_from_request(request)

      result = WhatsMyColorIntent.handle_request(request, response)

      assert result.response.outputSpeech.text ==
        "Your favorite color is red. Goodbye."
    end
  end
end
