defmodule AlexaJSON.RequestTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.{Request, RequestElement, Intent, Session, User, Application}

  @valid_attrs %{"version" => "1.0", "request" => %{
    "type" => "IntentRequest", "requestId" => "request123",
    "locale" => "en-US", "timestamp" => "2017-02-22T02:40:44Z", "intent" => %{
       "name" => "alexa skill", "slots" => %{"slot" => %{"name" => "value"}}
    }},
    "session" => %{
       "new" => true, "sessionId" => "session123",
       "application" => %{"applicationId" => "application123"},
       "user" => %{"userId" => "user123"},
       "attributes" => %{"attr" => %{"key" => "value"}}
    }
  }
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)
    request_struct = %Request{request:
      %RequestElement{intent:
        %Intent{name: "alexa skill",
          slots: %{"slot" => %{"name" => "value"}}
        }, locale: "en-US", requestId: "request123",
        timestamp: %DateTime{calendar: Calendar.ISO, day: 22, hour: 2,
          microsecond: {0, 0}, minute: 40, month: 2, second: 44, std_offset: 0,
          time_zone: "Etc/UTC", utc_offset: 0, year: 2017, zone_abbr: "UTC"},
        type: "IntentRequest"
      },
      session: %Session{application:
        %Application{applicationId: "application123"},
        attributes: %{"attr" => %{"key" => "value"}}, new: true,
        sessionId: "session123", user: %User{userId: "user123"}},
      version: "1.0"}


    changeset = Request.changeset(%Request{}, attrs)
    request = apply_changes(changeset)

    assert get_change(changeset, :version) == "1.0"
    assert request == request_struct
  end
end
