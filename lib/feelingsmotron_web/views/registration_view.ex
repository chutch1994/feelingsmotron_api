defmodule FeelingsmotronWeb.RegistrationView do
  use FeelingsmotronWeb, :view
  alias FeelingsmotronWeb.RegistrationView

  def render("registration.json", %{user: user, jwt: jwt}) do
    %{user: render_one(user, RegistrationView, "user.json", as: :user),
      jwt: jwt}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email}
  end
end