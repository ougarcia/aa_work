User.create!(email: "oscar@example.com", password: "password" )
User.create!(email: "bob@example.com", password: "password" )

Band.create!(name: "The xx")
Band.create!(name: "M83")

Album.create!(title: "xx", performance_type: 0, band_id: 1)
Track.create!(title: "VCR", track_type: 0, album_id: 1)
