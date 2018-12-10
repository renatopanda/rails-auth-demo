# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# db/seeds.rb
num_comments = (1..1000).to_a
articles = []
comments = []
20.times do |i|
	a = Article.new(name: "Article #{i}", content:"Article content...", published:true)
	articles << a
end

Article.import articles

articles = Article.all
articles.each do |a|
	num_comments.sample.times do |i|
		c = Comment.new(content: "Comment #{i} from article #{a.id}", article: a)
		comments << c
	end
end

Comment.import comments

Article.create(name: "Article without comments", content:"Article content...", published:true)
