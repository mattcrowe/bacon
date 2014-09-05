namespace :db do
  task populate: :environment do

    Client.destroy_all

    15.times do
      Client.create(
          name: Faker::HipsterIpsum.words(2).join(' '),
          contact: Faker::Name.first_name,
          email: Faker::Internet.email,
          rate: Faker::PhoneNumber.phone_number,
          address1: Faker::HipsterIpsum.words(2).join(' '),
          address2: Faker::HipsterIpsum.words(2).join(' '),
          city: Faker::HipsterIpsum.words(2).join(' '),
          state: Faker::HipsterIpsum.words(2).join(' '),
          zip: Faker::HipsterIpsum.words(2).join(' ')
      )
    end

  end
end