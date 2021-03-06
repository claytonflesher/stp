FactoryGirl.define do
  factory :patient do
    username              "example_user"
    password              "testPassword111"
    email                 "example_user@example.com"
    zipcode               "73110-111"
    former_religion       "Scientology"
    description           "I didn't ask to be made: no one consulted me or considered my feelings in the matter. I don't think it even occurred to them that I might have feelings. After I was made, I was left in a dark room for six months... and me with this terrible pain in all the diodes down my left side."
  end
end
