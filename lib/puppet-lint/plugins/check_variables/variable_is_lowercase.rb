# frozen_string_literal: true

# Public: Test the manifest tokens for variables that contain an uppercase
# letter and record a warning for each instance found.
#
# No style guide reference
PuppetLint.new_check(:variable_is_lowercase) do
  VARIABLE_LOWERCASE_TYPES = Set[:VARIABLE, :UNENC_VARIABLE]

  def check
    tokens.map do |token|
      next unless VARIABLE_LOWERCASE_TYPES.include?(token.type) ||
                  token.value.gsub(%r{\[.+?\]}, '').match?(%r{[A-Z]})

      notify(
        :warning,
        message: 'variable contains an uppercase letter',
        line: token.line,
        column: token.column
      )
    end
  end
end
