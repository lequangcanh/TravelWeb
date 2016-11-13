# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
province_names = ['An Giang', 'Bà Rịa - Vũng Tàu', 'Bắc Giang', 'Bắc Kạn',
                  'Bạc Liêu', 'Bắc Ninh', 'Bến Tre', 'Bình Định', 'Bình Dương',
                  'Bình Phước', 'Bình Thuận', 'Cà Mau', 'Cao Bằng', 'Đắk Lắk',
                  'Đắk Nông', 'Điện Biên', 'Đồng Nai', 'Đồng Tháp', 'Gia Lai',
                  'Hà Giang', 'Hà Nam', 'Hà Tĩnh', 'Hải Dương', 'Hậu Giang',
                  'Hòa Bình', 'Hưng Yên', 'Khánh Hòa', 'Kiên Giang', 'Kon Tum',
                  'Lai Châu', 'Lâm Đồng', 'Lạng Sơn', 'Lào Cai', 'Long An',
                  'Nam Định', 'Nghệ An', 'Ninh Bình', 'Ninh Thuận', 'Phú Thọ',
                  'Quảng Bình', 'Quảng Nam', 'Quảng Ngãi', 'Quảng Ninh',
                  'Quảng Trị', 'Sóc Trăng', 'Sơn La', 'Tây Ninh', 'Thái Bình',
                  'Thái Nguyên', 'Thanh Hóa', 'Thừa Thiên Huế', 'Tiền Giang',
                  'Trà Vinh', 'Tuyên Quang', 'Vĩnh Long', 'Vĩnh Phúc',
                  'Yên Bái', 'Phú Yên', 'Cần Thơ', 'Đà Nẵng', 'Hải Phòng',
                  'Hà Nội', 'TP HCM'].sort!
province_names.each { |province_name|
  Province.create!(name: province_name)
}

120.times do
  Place.new(name: Faker::Company.name,
            description: Faker::Lorem.paragraph(2),
            province_id: Faker::Number.between(1, 63)).save(validate: false)
end

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@travel.org"
  password = 'password'
  begin
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password)
  rescue ActiveRecord::RecordInvalid => e
    puts e.record.errors.full_messages
  end
end

Place.all.each do |place|
  10.times do
    offset = rand(User.count)
    random_user = User.offset(offset).first
    place.place_comments.create(date: Time.zone.now,
                                content: Faker::Lorem.paragraph(2),
                                user_id: random_user.id)
  end
end

100.times do
  Hotel.create(name: Faker::Company.name,
               details: Faker::Lorem.paragraph(2),
               website: Faker::Internet.domain_name,
               phone: Faker::PhoneNumber.phone_number,
               province_id: Faker::Number.between(1, 63))
end

100.times do
  Restaurant.create(name: Faker::Company.name,
                    details: Faker::Lorem.paragraph(2),
                    website: Faker::Internet.domain_name,
                    phone: Faker::PhoneNumber.phone_number,
                    province_id: Faker::Number.between(1, 63))
end
