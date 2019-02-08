# frozen_string_literal: true

# Public: Check the manifest tokens for lines ending with whitespace and record
# an error for each instance found.
#
# https://puppet.com/docs/puppet/latest/style_guide.html#spacing-indentation-and-whitespace
PuppetLint.new_check(:trailing_whitespace) do
  def check
    tokens.each do |token|
      next unless %i[WHITESPACE INDENT].include?(token.type)
      next if token.next_token.nil? || token.next_token.type == :NEWLINE
      notify(
        :error,
        message: 'trailing whitespace found',
        line: token.line,
        column: token.column,
        token: token
      )
    end
  end

  def fix(problem)
    return if problem[:token].nil?

    prev_token = problem[:token].prev_token
    next_token = problem[:token].next_token
    prev_token.next_token = next_token
    next_token&.prev_token = prev_token
    tokens.delete(problem[:token])
  end
end
