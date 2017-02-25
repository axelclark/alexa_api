defmodule AlexaJSON.SessionTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.Session

  @valid_attrs %{"new" => true, "sessionId" => "session123",
    "application" => %{"applicationId" => "application123"},
    "user" => %{"userId" => "user123"},
    "attributes" => %{"attr" => %{"key" => "value"}}
  }
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)
    session_struct = %Session{sessionId: "session123", new: true,
      attributes: %{"attr" => %{"key" => "value"}},
      application: %AlexaJSON.Application{applicationId: "application123"},
      user: %AlexaJSON.User{userId: "user123"}}

    changeset = Session.changeset(%Session{}, attrs)
    session = apply_changes(changeset)

    assert get_change(changeset, :sessionId) == "session123"
    assert session == session_struct
  end
end
