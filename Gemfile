source("https://rubygems.org")

gem("sinatra-activerecord")
gem("sinatra-contrib", :require => "sinatra/reloader")
gem("rake")
gem("pg")
gem("pry")

group(:test) do
  gem('capybara', require: "capybara/rspec")
  gem("rspec")
  gem('launchy')
  gem('shoulda-matchers')
end

group(:production) do
  gem("sinatra")
end
