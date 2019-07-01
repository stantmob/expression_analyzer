class ExpressionAnalyzer
    
  def expression_dudao(expression_string)
    expression_string = expression_string.delete(' ')
    
    expression_string.split(%r{(\*)+}, 0)
    
    expression_string.split(%r{(\*)+}, 0)
    
#(\d\s*\*)+ 3*
    evaluate(expression_string)
  end

  def evaluate(expression)
    if expression.include?('*') || expression.include?('/')
      split = expression.split(%r{(\*|\/)+}, 0)
      evaluate(split[0]).send(split[1], evaluate(split[2]))
    elsif expression.include?('+') || expression.include?('-')
      split = expression.split(%r{(\+|\-)+}, 0)
      evaluate(split[0]).send(split[1], evaluate(split[2]))
    elsif expression.include?('(')
      expression.delete('(').to_i
    elsif expression.include?(')')
      expression.delete(')').to_i 
    else 
      expression.to_i
    end
  end

  
end
