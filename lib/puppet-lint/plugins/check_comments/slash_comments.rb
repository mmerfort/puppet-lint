# frozen_string_literal: true

# Public: Check the manifest tokens for any comments started with slashes
# (//) and record a warning for each instance found.
#
# https://puppet.com/docs/puppet/latest/style_guide.html#comments
PuppetLint.new_check(:slash_comments) do
  def check
    tokens.each do |token|
      next unless token.type == :SLASH_COMMENT
      notify(
        :warning,
        message: '// comment found',
        line: token.line,
        column: token.column,
        token: token
      )
    end
  end

  def fix(problem)
    problem[:token].type = :COMMENT
  end
end
