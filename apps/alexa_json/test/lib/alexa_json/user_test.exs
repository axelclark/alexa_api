defmodule AlexaJSON.UserTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.User

  @valid_attrs %{"userId" => "user123"}
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)

    changeset = User.changeset(%User{}, attrs)

    assert get_change(changeset, :userId) == "user123"
    assert get_change(changeset, :test) == nil
  end
end
