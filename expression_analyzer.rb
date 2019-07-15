class ExpressionAnalyzer
    
  def expression_dudao(expression_string)
    expression_string = expression_string.delete(' ')
    
#(\d\s*\*)+ 3*
    evaluate(expression_string)
  end

  def evaluate(expression)
    if expression.index('[')
      split = start_evaluation(expression, '[', ']')
      evaluate(split[0]).send(split[1], evaluate(split[2]))
    elsif expression.index('(')
      split = start_evaluation(expression, '(', ')')
      evaluate(split[0]).send(split[1], evaluate(split[2]))
    elsif index = (expression.index('+') || expression.index('-'))
      split = slice_at(expression, index)
      evaluate(split[0]).send(split[1], evaluate(split[2]))
    elsif index = (expression.index('*') || expression.index('/'))
      split = slice_at(expression, index)
      evaluate(split[0]).send(split[1], evaluate(split[2]))
    else 
      expression.to_i
    end
  end

  def start_evaluation(expression, symbol, closing_symbol)
    index = expression.index(symbol)
    
    split = slice_at(expression, index)

    closing_parenthesis_index = expression.index(closing_symbol)
    expression.slice!(closing_parenthesis_index)
    expression.slice!(index)
    split = slice_at(expression, index-1)

    if index == 0
      split = slice_at(expression, closing_parenthesis_index-1)
    end

    split
  end

  def slice_at(expression, index)
    [expression.slice(0..index-1), expression[index], expression.slice(index+1..-1)]
  end


end
