bas_lyrics = "
I'm glad to see you
I had a funny dream
You were wearing funny shoes
You were going to a dance
You were dressed like a punk but you are too young
to remember

Glad to see you
I'm outside the house
I'm not thinking right today
I've got no energy
I'm glad that you are waiting with me
Tell me all about your day

Breaking off is misery
I see a wilderness for you and me
Punctuated by philosophy
And a wondering how things could've been

I'm happy for you
You've made it hard for me
I counted on your company
You are staying with your friends tonight
I'm feeling sorry for myself
I keep taking everything to be a sign

I'm happy for you
Now I know this hurt is poison
Too sharp to be bled
I'm sitting on my empty bed
On my empty bed
At night the fever grows it's pounding pounding

I'd rather be in Tokyo
I'd rather listen to Thin Lizzy-oh
Watch the Sunday gang in Harajuku
There's something wrong with me, I'm a cuckoo

Scary moment, lovin' every moment
I was high from playing shows
We lost a singer to her clothes
My trouble raised its ugly head
I was revealed
And I was home in bed
I was a kid again

Jesus told me, go after every coin like it was the last in
the world
And protect the wayward child
But I'm a little lost sheep
I need my Bo Peep
I know I need My Shepherd here tonight

Breaking off is misery
I see a wilderness for you and me
Punctuated by philosophy
And a wondering how things could've been

I'd like to see you
But really I should stay away
And let you settle down
I've got no claims to your crown
I was the boss of you
And I loved you
You know I loved you
It's all over now

I was there for you
When you were lonely
I was there when you were bad
I was there when you were sad
Now it's my time of need
I'm thinking, do I have to plead to get you by my side?

I'd rather be in Tokyo
I'd rather listen to Thin Lizzy-oh
Watch the Sunday gang in Harajuku
There's something wrong with me, I'm a cuckoo
"

User.create!(email: "oscar@example.com", password: "oscaroscaroscar" )
User.create!(email: "bob@example.com", password: "bobbobbob" )

Band.create!(name: "The xx")
Band.create!(name: "M83")
Band.create!(name: "Belle & Sebastian")

Album.create!(title: "xx", performance_type: 0, band_id: 1)
Album.create!(title: "Hurry Up, We're Dreaming!", performance_type: 0, band_id: 2)
Album.create!(title: "Dear Catastrophe Waitress", performance_type: 0, band_id: 3)
Album.create!(title: "If You're Feeling Sinister", performance_type: 0, band_id: 3)

Track.create!(title: "VCR", track_type: 0, album_id: 1)
Track.create!(title: "Steve McQueen", track_type: 0, album_id: 2)
Track.create!(title: "I'm a Cuckoo", track_type: 0, album_id: 3, lyrics: bas_lyrics)
Track.create!(title: "Piazza, New York Catcher", track_type: 0, album_id: 3)
Track.create!(title: "Get me Away from Here I'm Dying", track_type: 0, album_id: 4)

