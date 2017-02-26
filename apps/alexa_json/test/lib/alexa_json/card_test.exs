defmodule AlexaJSON.CardTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.Card

  @valid_attrs %{
    "type" => "string",
    "title" => "string",
    "content" => "string",
    "text" => "string",
    "image" => %{
      "smallImageUrl" => "string",
      "largeImageUrl" => "string"
    }
  }
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)
    card_struct = %Card{content: "string", text: "string", title: "string",
      image: %AlexaJSON.Image{largeImageUrl: "string", smallImageUrl: "string"},
      type: "string"}

    changeset = Card.changeset(%Card{}, attrs)
    result = apply_changes(changeset)

    assert result == card_struct
  end
end
