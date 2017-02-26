defmodule AlexaJSON.OutputSpeechTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.OutputSpeech

  @valid_attrs %{"type" => "text", "text" => "hi", "ssml" => "hiyo"}
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)

    changeset = OutputSpeech.changeset(%OutputSpeech{}, attrs)

    assert get_change(changeset, :type) == "text"
    assert get_change(changeset, :text) == "hi"
    assert get_change(changeset, :ssml) == "hiyo"
    assert get_change(changeset, :test) == nil
  end
end
