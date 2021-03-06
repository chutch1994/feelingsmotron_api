defmodule Feelingsmotron.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Feelingsmotron.Account.User


  schema "users" do
    field :email, :string
    field :name, :string

    field :password, :string, virtual: true
    field :password_hash, :string

    many_to_many :groups, Feelingsmotron.Groups.Group, join_through: Feelingsmotron.Groups.UserGroup

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_length(:password, min: 8)
    |> hash_password
    |> unique_constraint(:email, message: "is already in use")
  end

  @doc """
  Changeset for use when a user is updating their own profile.

  This changeset should not allow any properties to be changed which could
  elevate the user's privileges.
  """
  def profile_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email])
    |> validate_length(:password, min: 8)
    |> hash_password
    |> unique_constraint(:email, message: "is already in use")
  end

  @spec hash_password(%Ecto.Changeset{}) :: %Ecto.Changeset{}
  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
  end
  defp hash_password(changeset), do: changeset
end
