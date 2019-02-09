# Public: Test the manifest tokens for variables that contain a dash and
# record a warning for each instance found.
#
# No style guide reference
PuppetLint.new_check(:variable_contains_dash) do
  VARIABLE_DASH_TYPES = Set[:VARIABLE, :UNENC_VARIABLE]

  def check
    tokens.map do |token|
      next unless VARIABLE_DASH_TYPES.include?(token.type)
      next unless token.value.gsub(%r{\[.+?\]}, '').match?(%r{-})

      notify(
        :warning,
        message: 'variable contains a dash',
        line: token.line,
        column: token.column
      )
    end
  end
end
