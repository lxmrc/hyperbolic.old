FactoryBot.define do
  factory :exercise do
    name { "Hello World" }
    icon { "world" }
    description { "A basic exercise." }
    test_file { Rack::Test::UploadedFile.new("./spec/fixtures/hello_world_test.rb", "text/plain") }
  end
end
