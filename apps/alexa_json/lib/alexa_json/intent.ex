defmodule AlexaJSON.Intent do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :name, :string
    field :slots, :map
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:name, :slots])
  end
end
