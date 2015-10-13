[![Build Status](https://travis-ci.org/Arvinje/lexigen.svg)](https://travis-ci.org/Arvinje/lexigen)
# Lexigen

## Currently experimenting some ideas!

### 1. Define the state machine

```ruby
Lexigen.define do |sm|
  sm.from(0).to(1).if(/w+/)
  sm.from(1).to(2).if(/d+/)
end
```

It returns an instance of StateMachine:
```ruby
=> #<Lexigen::StateMachine:0x007f9958823220
 @if_conditions=[/w+/, /d+/],
 @matrix=Matrix[[nil, {:if=>/w+/, :unless=>nil}, nil], [nil, nil, {:if=>/d+/, :unless=>nil}], [nil, nil, nil]],
 @states=[[0, 1], [1, 2]],
 @unless_conditions=[]>
```
