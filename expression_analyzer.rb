# frozen_string_literal: true

class ExpressionAnalyzer
  def initialize(expression)
    @expression = expression.delete(' ')
  end

  def call
    evaluate(@expression)
  end

  private

  def evaluate(expression)
    return expression.to_i if integer?(expression)

    {
      '[' => :start_evaluation,
      '(' => :start_evaluation,
      '+' => :slice_at,
      '-' => :slice_at,
      '*' => :slice_at,
      '/' => :slice_at
    }.each do |key, value|
      if expression.index(key)
        split = split(expression, key, value)
        return evaluate(split[0]).send(split[1], evaluate(split[2]))
      end
    end
  end

  def integer?(string)
    Integer(string)
  rescue ArgumentError
    false
  end

  def split(expression, symbol, method)
    closing = { '[' => ']', '(' => ')' }

    sliced_expression = {
      start_evaluation: lambda do
        start_evaluation(expression, symbol, closing[symbol])
      end,
      slice_at: lambda do
        index = expression.index(symbol)
        slice_at(expression, index)
      end
    }
    sliced_expression[method].call
  end

  def start_evaluation(expression, symbol, closing_symbol)
    index = expression.index(symbol)

    closing_parenthesis_index = expression.index(closing_symbol)
    expression.slice!(closing_parenthesis_index)
    expression.slice!(index)
    split = slice_at(expression, index - 1)

    split = slice_at(expression, closing_parenthesis_index - 1) if index.zero?
    split
  end

  def slice_at(expression, index)
    [expression.slice(0..index - 1),
     expression[index],
     expression.slice(index + 1..-1)]
  end
end
