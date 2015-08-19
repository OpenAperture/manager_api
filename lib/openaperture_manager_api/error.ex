#
# == error.ex
#
# This module contains the standard error definition for OpenAperture.ManagerApi
#
defmodule OpenAperture.ManagerApi.Error do
  @moduledoc """
  This module contains the standard error definition for OpenAperture.ManagerApi
  """

  defstruct stacktrace: nil, kind: nil, error: nil

  @doc """
  Method to generate a standardized error

  ## Options
  The `kind` option defines the error type

  The `error` option defines the actual error

  ## Return Values

  OpenAperture.ManagerApi.Error
  """
  @spec process(term, term) :: term
  def process(kind, error) do
    %__MODULE__{
      stacktrace: Exception.format(kind, error),
      kind: kind,
      error: error
    }
  end
end
