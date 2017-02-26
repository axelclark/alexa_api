defmodule AlexaJSON.RepromptTest do
  use ExUnit.Case
  import Ecto.Changeset
  alias AlexaJSON.Reprompt

  @valid_attrs %{"outputSpeech" =>
    %{"type" => "text", "text" => "hi", "ssml" => "hiyo"}}
  @invalid_attrs %{"test" => "test"}

  test "changeset casts only valid attributes" do
    attrs = Map.merge(@valid_attrs, @invalid_attrs)
    reprompt_struct = %AlexaJSON.Reprompt{outputSpeech:
      %AlexaJSON.OutputSpeech{ssml: "hiyo", text: "hi", type: "text"}}

    changeset = Reprompt.changeset(%Reprompt{}, attrs)
    result = apply_changes(changeset)

    assert get_change(changeset, :test) == nil
    assert result == reprompt_struct
  end
end
