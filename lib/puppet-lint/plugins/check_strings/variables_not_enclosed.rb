# frozen_string_literal: true

# Public: Check the manifest tokens for any variables in a string that have
# not been enclosed by braces ({}) and record a warning for each instance
# found.
#
# https://puppet.com/docs/puppet/latest/style_guide.html#quoting
PuppetLint.new_check(:variables_not_enclosed) do
  def check
    tokens.each do |token|
      next unless token.type == :UNENC_VARIABLE
      notify(
        :warning,
        message: 'variable not enclosed in {}',
        line: token.line,
        column: token.column,
        token: token
      )
    end
  end

  def fix(problem)
    problem[:token].type = :VARIABLE
  end
end
