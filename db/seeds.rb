# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tweet.destroy_all
User.destroy_all

puts '-- Creando usuarios --'
puts '-- Creando usuario de Alejandro --'

# our_user = User.create(name: "Alejandro", email: "alejandro@example.com", nickname: "alejandro", picture: 'https://bulma.io/images/placeholders/64x64.png', password: '123456')
our_user = User.first
10.times do |j|
    Tweet.create(user: our_user, tweet: "Este es el tweet ##{j + 1}")
end

puts '-- Usuario de Alejandro creado --'

10.times do |i|
    puts "-- Creando usuario Usuario 0#{i} --"
    u = User.create(name: "Usuario 0#{i}", email: "usuario0#{i}@example.com", nickname: "user_0#{i}", picture: 'https://bulma.io/images/placeholders/64x64.png', password: '123456')
    
    random = (1..10).to_a.sample
    random.times do |j|
        current_date = Date.today - j.days
        t = Tweet.new(user: u, tweet: "Este es el tweet ##{j + 1}", created_at: current_date, updated_at: current_date)
        t.save
    end
    puts "-- Usuario 0#{i} creado --"
end

puts '-- Usuarios Creados --'
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?