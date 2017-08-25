defmodule Rumbl.Media.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Media.Video


  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    belongs_to :user, Rumbl.User
    belongs_to :category, Rumbl.Media.Category

    timestamps()
  end

  @doc false
  def changeset(%Video{} = video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description])
    |> validate_required([:url, :title, :description])
  end
end
