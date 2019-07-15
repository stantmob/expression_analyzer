require 'spec_helper'
require './expression_analyzer'

describe ExpressionAnalyzer do
 
  context 'when pass a expression 3 * (2 + 5)' do
    
  let(:result) { subject.expression_dudao('3 * (2 + 5)') }
    
    it 'should return 21' do
      expect(result).to eq 21 
    end
  end

  context 'when pass a expression (2 + 5) * 3 ' do
    
  let(:result) { subject.expression_dudao('(2 + 5) * 3') }
    
    it 'should return 21' do
      expect(result).to eq 21 
    end
  end

  context 'when pass a expression (2 - 5) * 3 ' do
    let(:result) { subject.expression_dudao('(2 - 5) * 3') }
    
    it 'should return -9' do
      expect(result).to eq -9 
    end
  end
  
  context 'when pass a expression 3 * (2 - 5)' do
    let(:result) { subject.expression_dudao('3 * (2 - 5)') }
    
    it 'should return -9' do
      expect(result).to eq -9 
    end
  end

  context 'when pass a expression 3 / (2 - 5)' do
    let(:result) { subject.expression_dudao('3 / (2 - 5)') }
    
    it 'should return -1' do
      expect(result).to eq -1 
    end
  end

  context 'when pass a expression 30 / (2 * 5)' do
    let(:result) { subject.expression_dudao('30 / (2 * 5)') }
    
    it 'should return 3' do
      expect(result).to eq 3 
    end
  end

  context 'when pass a expression [30 / (2 * 5)] + 5' do
    let(:result) { subject.expression_dudao('[30 / (2 * 5)] + 5') }
    
    it 'should return 8' do
      expect(result).to eq 8 
    end
  end
 end
