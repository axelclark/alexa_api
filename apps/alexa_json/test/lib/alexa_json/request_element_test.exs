defmodule AlexaJSON.RequestElementTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.RequestElement

  @valid_attrs %{"type" => "IntentRequest", "requestId" => "request123",
    "locale" => "en-US", "timestamp" => "2017-02-22T02:40:44Z", "intent" => %{
       "name" => "alexa skill", "slots" => %{"slot" => %{"name" => "value"}}
     }}
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)
    request_element_struct = %RequestElement{
      intent: %AlexaJSON.Intent{name: "alexa skill",
        slots: %{"slot" => %{"name" => "value"}}},
      locale: "en-US", requestId: "request123",
      timestamp: %DateTime{calendar: Calendar.ISO, day: 22, hour: 2,
        microsecond: {0, 0}, minute: 40, month: 2, second: 44, std_offset: 0,
        time_zone: "Etc/UTC", utc_offset: 0, year: 2017, zone_abbr: "UTC"},
      type: "IntentRequest"}

    changeset = RequestElement.changeset(%RequestElement{}, attrs)
    request_element = apply_changes(changeset)

    assert get_change(changeset, :requestId) == "request123"
    assert request_element == request_element_struct
  end
end
