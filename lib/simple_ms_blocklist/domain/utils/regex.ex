defmodule SimpleMsBlocklist.Utils.Regex do
  @moduledoc false

  def without_numbers, do: ~r/^([^0-9]*)$/

  def with_space, do: ~r/[[:space:]]/

  def non_digits, do: ~r/\D+/

  def only_numbers?(string) do
    result = contains_letters?(Regex.replace(~r/[^a-zA-Z]/, string, ""))

    if result, do: false, else: true
  end

  def contains_letters?(string), do: Regex.match?(~r/[^a-zA-Z]/, string)

  def contains_upper_case_letter, do: ~r/[A-Z]+/

  def contains_lower_case_letter, do: ~r/[a-z]+/

  def contains_number, do: ~r/[0-9]+/

  def contains_symbol, do: ~r/[#\!\?&@\$%^&*\(\)]+/

  def format_date_iso, do: ~r/^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/

  def format_date_br, do: ~r/^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$/
end
