defmodule AlexaJSON.IntentTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.Intent

  @valid_attrs %{"name" => "alexa skill",
                 "slots" => %{"slot" => %{"name" => "value"}}}
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)

    changeset = Intent.changeset(%Intent{}, attrs)

    assert get_change(changeset, :name) == "alexa skill"
    assert get_change(changeset, :slots) == %{"slot" => %{"name" => "value"}}
  end
end
