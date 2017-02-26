defmodule AlexaJSON.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
      field :userId, :string, default: ""
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:userId])
  end
end
