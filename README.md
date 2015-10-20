[![Build Status](https://travis-ci.org/Arvinje/lexigen.svg)](https://travis-ci.org/Arvinje/lexigen)
# Lexigen

## Currently experimenting some ideas!

### 1. Define the state machine (TO BE CHANGED!)

```ruby
machine = Lexigen.define do
  from(0).to(1).if(/\d/)
  from(1).to(1).if(/\d/)
  from(1).unless(/\d/).return_as(:integer)

  from(1).to(2).if(/\./)
  from(2).to(2).if(/\d/)
  from(2).unless(/\d/).return_as(:float)
end
```

It returns an instance of StateMachine:
```ruby
=> #<Lexigen::StateMachine:0x007fcb621e81d0
 @matrix=
  Matrix[[nil, {:if=>/\d/, :unless=>nil}, nil], [nil, {:if=>/\d/, :unless=>nil}, {:if=>/\./, :unless=>nil}], [nil, nil, {:if=>/\d/, :unless=>nil}]],
 @return_tokens=[nil, {:if=>nil, :unless=>/\d/, :type=>:integer}, {:if=>nil, :unless=>/\d/, :type=>:float}]>
```

## 2. Generate a lexer in the specified language

```ruby
machine.generate_lexer :ruby
# generates the lexer in ruby
# using ruby_generator.rb
```
