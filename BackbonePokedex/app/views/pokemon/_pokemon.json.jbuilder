json.(pokemon, *Pokemon.column_names)

if toys
  json.toys do
    json.array!(pokemon.toys) do |toy|
      json.partial!('toys/toy', toy: toy)
    end
  end
end
