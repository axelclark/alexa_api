defmodule AlexaJSON.ApplicationTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.Application

  @valid_attrs %{"applicationId" => "application123"}
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)

    changeset = Application.changeset(%Application{}, attrs)

    assert get_change(changeset, :applicationId) == "application123"
  end
end
