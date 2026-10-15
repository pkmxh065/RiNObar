# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Test_user = user.find_or_create_by!(email: "sample@gmail.com") do |user|
  user.name = "testuser"
  user.password = "password"
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"),filename:"sample-user1.jpg")
end

Novel.create!([
  {
    novel_id: 1,
    title: '異世界からの帰還者',
    genre: 'ファンタジー',
    story: '長い旅の終わりに、主人公は元の世界へと戻ってきた。しかし、そこにはかつての日常とは違う影が忍び寄っていた。',
    thought: '王道なプロットながら、心理描写を丁寧に描きたい作品。',
    user_id: user.id
  },
  {
    novel_id: 2,
    title: '深夜2時のタイピスト',
    genre: 'ミステリー',
    story: '誰もいないオフィスで、毎晩聞こえてくるタイプライターの音。その音が刻んでいたのは、未解決事件の真相だった。',
    thought: '短編小説としてテンポよく読めるように構成を意識した。',
    user_id: user.id
  }
])

puts "サンプル小説データの作成が完了しました！(合計: #{Novel.count}件)"