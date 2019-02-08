# frozen_string_literal: true

# Public: Check the manifest tokens for any single quoted strings containing
# a enclosed variable and record an error for each instance found.
#
# https://puppet.com/docs/puppet/latest/style_guide.html#quoting
PuppetLint.new_check(:single_quote_string_with_variables) do
  def check
    tokens.each do |token|
      next unless token.type == :SSTRING &&
                  token.value.include?('${') &&
                  !token.prev_token.prev_token.value.match(%r{inline_(epp|template)})
      notify(
        :error,
        message: 'single quoted string containing a variable found',
        line: token.line,
        column: token.column
      )
    end
  end
end
