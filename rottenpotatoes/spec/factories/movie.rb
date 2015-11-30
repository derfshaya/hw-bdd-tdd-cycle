FactoryGirl.define do
    factory :movie do
        id 101
        title 'A Fake Title'
        rating 'PG'
        release_date { 8.years.ago }
        director 'Alan Smithee'
    end
end