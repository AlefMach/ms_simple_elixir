defmodule SimpleMsBlocklistWeb.ErrorView do
  use SimpleMsBlocklistWeb, :view

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  @doc """
  Error for template not found
  """
  def template_not_found(template, _assigns) do
    %{
      error: %{
        details: Phoenix.Controller.status_message_from_template(template)
      }
    }
  end

  @doc """
  Error for Ecto Changeset validation
  """
  def render("error.json", %{changeset: %Ecto.Changeset{} = changeset}) do
    %{
      error: %{
        details: translate_errors(changeset)
      }
    }
  end

  @doc """
  Error specifying the resource id related
  """
  def render("error.json", %{reason: reason, resource_id: resource_id}) do
    %{
      error: %{
        details: reason,
        resourceId: resource_id
      }
    }
  end

  @doc """
  Error default with detials only
  """
  def render("error.json", %{reason: reason}) do
    %{
      error: %{
        details: reason
      }
    }
  end

  @doc """
  Error default with list errors
  """
  def render("error.json", %{error: [error]}) do
    %{
      error: %{
        details: error
      }
    }
  end

  @doc """
  Error default with error
  """
  def render("error.json", %{error: error}) do
    %{
      message: error
    }
  end
end
