# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "seed start"

user1 = User.find_or_create_by!(email_address: "test1@example.com") do |user|
  user.name = "testuser1"
  user.password = "password"
  user.password_confirmation = "password"
end

user2 = User.find_or_create_by!(email_address: "test2@example.com") do |user|
  user.name = "testuser2"
  user.password = "password"
  user.password_confirmation = "password"
end

Novel.find_or_create_by!(title: "異世界のんびり農家", user: user1) do |novel|
  novel.genre_main = "異世界"
  novel.genre_sub = "転生"
  novel.story = "のんびり暮らす話"
  novel.thought = "テスト用投稿です"
end

Novel.find_or_create_by!(title: "学園バトル", user: user2) do |novel|
  novel.genre_main = "学園"
  novel.genre_sub = "バトル"
  novel.story = "仲間と戦う話"
  novel.thought = "確認用投稿です"
end

puts "seed end"