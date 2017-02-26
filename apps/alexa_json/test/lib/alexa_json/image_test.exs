defmodule AlexaJSON.ImageTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.Image

  @valid_attrs %{"largeImageUrl" => "www.largeimage.com",
    "smallImageUrl" => "www.smallimage.com"}
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)

    changeset = Image.changeset(%Image{}, attrs)

    assert get_change(changeset, :largeImageUrl) == "www.largeimage.com"
    assert get_change(changeset, :smallImageUrl) == "www.smallimage.com"
    assert get_change(changeset, :test) == nil
  end
end
