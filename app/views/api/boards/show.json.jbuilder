json.(@board, :id, :title)

json.lists do
  json.array! @board.lists do |list|
    json.(list,:id, :title)

    json.cards do
      json.array! list.cards do |card|
        json.(card, :id, :title)
        json.items do
          json.array! card.items do |item|
            json.(item, :id, :title)
          end
        end
      end
    end

  end
end

