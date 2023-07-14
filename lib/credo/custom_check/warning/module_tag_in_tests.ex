defmodule Credo.CustomCheck.Warning.ModuleTagInTests do
  @moduledoc false
  use Credo.Check,
    base_priority: :high,
    category: :warning,
    explanations: [
      check: """
      We need to set the @moduletag as :integration or :unit for the tests in order to
      successfully execute them in our CI pipeline.
      """
    ]

  alias Credo.Code.Module

  @test_files_with_exs_ending_regex ~r/test\/.*\/.*_test.exs$/

  @spec run(source_file :: SourceFile.t(), params :: Keyword.t()) :: [Credo.Issue.t()]
  def run(%SourceFile{filename: filename} = source_file, params \\ []) do
    if matches?(filename, @test_files_with_exs_ending_regex) do
      issue_meta = IssueMeta.for(source_file, params)

      {_continue, issues} =
        Credo.Code.prewalk(
          source_file,
          &traverse(&1, &2, issue_meta),
          {true, []}
        )

      issues
    else
      []
    end
  end

  defp traverse(
         {:defmodule, meta, _arguments} = ast,
         {true, issues},
         issue_meta
       ) do
    mod_name = Module.name(ast)

    case Module.attribute(ast, :moduletag) do
      {:error, _} ->
        {
          ast,
          {true,
           [
             issue_for(
               "Test modules must have a @moduletag tag.",
               issue_meta,
               meta[:line],
               mod_name
             )
           ] ++ issues}
        }

      tag ->
        if tag in [:integration, :unit] do
          {ast, {true, issues}}
        else
          {
            ast,
            {true,
             [
               issue_for(
                 "Test modules with `@moduletag` must be either :integration or :unit.",
                 issue_meta,
                 meta[:line],
                 mod_name
               )
             ] ++ issues}
          }
        end
    end
  end

  defp traverse(ast, {continue, issues}, _issue_meta) do
    {ast, {continue, issues}}
  end

  defp matches?(directory, path) when is_binary(path), do: String.starts_with?(directory, path)
  defp matches?(directory, %Regex{} = regex), do: Regex.match?(regex, directory)

  defp issue_for(message, issue_meta, line_no, trigger) do
    format_issue(
      issue_meta,
      message: message,
      trigger: trigger,
      line_no: line_no
    )
  end
end
