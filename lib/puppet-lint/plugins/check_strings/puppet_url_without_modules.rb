# frozen_string_literal: true

# Public: Check the manifest tokens for any puppet:// URL strings where the
# path section doesn't start with modules/ and record a warning for each
# instance found.
#
# No style guide reference
PuppetLint.new_check(:puppet_url_without_modules) do
  def check
    tokens.each do |token|
      next unless (token.type == :SSTRING || token.type == :STRING || token.type == :DQPRE) &&
                  token.value.start_with?('puppet://')
      next if token.value[%r{puppet://.*?/(.+)}, 1]&.start_with?('modules/')
      notify(
        :warning,
        message: 'puppet:// URL without modules/ found',
        line: token.line,
        column: token.column,
        token: token
      )
    end
  end

  def fix(problem)
    problem[:token].value.gsub!(%r{(puppet://.*?/)}, '\1modules/')
  end
end
