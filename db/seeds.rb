# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'csv'
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'

Faker::Config.locale = 'fr'

User.destroy_all
City.destroy_all
Gossip.destroy_all
Tag.destroy_all
PrivateMessage.destroy_all
JoinTableMessageRecipient.destroy_all
Comment.destroy_all
Like.destroy_all

def pick_quote
  quote_reservoir = [
    Faker::TvShows::AquaTeenHungerForce,
    Faker::TvShows::BigBangTheory,
    Faker::TvShows::BojackHorseman,
    Faker::TvShows::Buffy,
    Faker::TvShows::DrWho,
    Faker::TvShows::DumbAndDumber,
    Faker::TvShows::FamilyGuy,
    Faker::TvShows::FinalSpace,
    Faker::TvShows::Friends,
    Faker::TvShows::GameOfThrones,
    Faker::TvShows::HeyArnold,
    Faker::TvShows::HowIMetYourMother,
    Faker::TvShows::MichaelScott,
    Faker::TvShows::NewGirl,
    Faker::TvShows::RickAndMorty,
    Faker::TvShows::RuPaul,
    Faker::TvShows::Seinfeld,
    Faker::TvShows::SiliconValley,
    Faker::TvShows::Simpsons,
    Faker::TvShows::SouthPark,
    Faker::TvShows::Stargate,
    Faker::TvShows::StrangerThings,
    Faker::TvShows::Suits,
    Faker::TvShows::TheExpanse,
    Faker::TvShows::TheFreshPrinceOfBelAir,
    Faker::TvShows::TheITCrowd,
    Faker::TvShows::TwinPeaks,
    Faker::TvShows::VentureBros,
    Faker::Movie,
    Faker::Movies::BackToTheFuture,
    Faker::Movies::Departed,
    Faker::Movies::Ghostbusters,
    Faker::Movies::HarryPotter,
    Faker::Movies::HitchhikersGuideToTheGalaxy,
    Faker::Movies::Hobbit,
    Faker::Movies::Lebowski,
    Faker::Movies::PrincessBride,
    Faker::Movies::StarWars,
    Faker::Movies::VForVendetta
  ]

  quote_reservoir.sample.quote
end

def pick_recipient (private_message)
  user = User.all.sample
  user == private_message.sender ? pick_recipient(private_message) : user
end

cities = []
CSV.foreach('./db/insee.csv', headers: true) do |row|
  city = row.to_h
  cities << City.new(
    name: city['Commune'].split.map { |w| w.capitalize }.join(' '),
    zip_code: city['Codepos']
  )
end
City.import cities, recursive: true

20.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: pick_quote,
    email: Faker::Internet.email,
    age: rand(18..80),
    city: City.all.sample,
    password: Faker::Internet.password
  )
end

10.times do
  Tag.create(
    title: Faker::Space.star
  )
end

50.times do
  gossip = Gossip.create(
    title: Faker::BossaNova.song,
    content: pick_quote,
    user: User.all.sample
  )

  JoinTableGossipTag.create(
    gossip: gossip,
    tag: Tag.all.sample
  )
end

20.times do
  JoinTableGossipTag.create(
    gossip: Gossip.all.sample,
    tag: Tag.all.sample
  )
end

50.times do
  pm = PrivateMessage.create(
    content: pick_quote,
    sender: User.all.sample
  )

  JoinTableMessageRecipient.create(
    private_message: pm,
    recipient: pick_recipient(pm)
  )
end

20.times do
  private_message = PrivateMessage.all[rand(0..49)]
  recipient = pick_recipient(private_message)

  while private_message.recipients.include?(recipient)
    recipient = pick_recipient(private_message)
  end

  JoinTableMessageRecipient.create(
    private_message: private_message,
    recipient: recipient
  )
end

40.times do
  Comment.create(
    commentable: Gossip.all.sample,
    user: User.all.sample,
    content: pick_quote
  )
end

60.times do
  if rand(0..1) == 0
    likeable = Comment.all.sample
  else
    likeable = Gossip.all.sample
  end

  Like.create(
    user: User.all.sample,
    likeable: likeable
  )
end

40.times do
  if rand(0..1) == 0
    commentable = Comment.all.sample
  else
    commentable = Gossip.all.sample
  end

  Comment.create(
    commentable: commentable,
    user: User.all.sample,
    content: pick_quote
  )
end
