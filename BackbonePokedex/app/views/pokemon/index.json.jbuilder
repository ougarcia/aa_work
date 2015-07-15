json.array! @pokemon do |pokemon|
  json.partial!('pokemon/pokemon', pokemon: pokemon, toys: false)
end
