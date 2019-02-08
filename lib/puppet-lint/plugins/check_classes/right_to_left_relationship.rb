# frozen_string_literal: true

# Public: Test the manifest tokens for any right-to-left (<-) chaining
# operators and record a warning for each instance found.
#
# https://puppet.com/docs/puppet/latest/style_guide.html#chaining-arrow-syntax
PuppetLint.new_check(:right_to_left_relationship) do
  def check
    tokens.select { |r| r.type == :OUT_EDGE }.each do |token|
      notify(
        :warning,
        message: 'right-to-left (<-) relationship',
        line: token.line,
        column: token.column
      )
    end
  end
end
