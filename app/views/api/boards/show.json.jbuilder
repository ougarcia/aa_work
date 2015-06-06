json.(@board, :id, :title)
 json.lists do
   json.array! @board.lists do |list|
     json.(list,:id, :title)
   end
 end
