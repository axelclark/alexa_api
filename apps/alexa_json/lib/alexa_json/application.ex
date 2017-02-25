defmodule AlexaJSON.Application do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
      field :applicationId, :string
  end

  def changeset(schema, data) do
    schema
    |> cast(data, [:applicationId])
  end
end
