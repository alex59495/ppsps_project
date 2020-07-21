# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create company
c = Company.create(name: "test company", address: "test company addres")
p "create #{c.id} company"

# Create users
users = [{
  email: "test1@gmail.com",
  password: "123456",
  admin: true
}, {
  email: "test2@gmail.com",
  password: "123456",
  admin: false
}]

users.each do |user|
  u = User.create(email: user[:email], password: user[:password], admin: user[:admin])
  p "create #{u.id} users"
end

# Create MOA
moa = {
  name: "Test MOA",
  address: "test address MOA",
  representative: "test representative MOA",
  phone: "0328261863",
  email: "alexis@gmail.com"
}

m = Moa.create(name: moa[:name], address: moa[:address], representative: moa[:representative], phone: moa[:phone], email: moa[:email])
p "create #{m.id} moa"

# Create PPSP
ppsps = [{
  address: "test_1 address",
  start: DateTime.new(2020,9,1,17),
  end: DateTime.new(2020,9,1,19),
  nature: "test_1 nature",
  workforce: "test_1 workforce",
  user_id: 1,
  company_id: 1,
  moa_id: 1,
}, {
  address: "test_2 address",
  start: DateTime.new(2020,9,1,17),
  end: DateTime.new(2020,9,1,19),
  nature: "test_2 nature",
  workforce: "test_2 workforce",
  user_id: 1,
  company_id: 1,
  moa_id: 1,
}, {
  address: "test_3 address",
  start: DateTime.new(2020,9,1,17),
  end: DateTime.new(2020,9,1,19),
  nature: "test_3 nature",
  workforce: "test_3 workforce",
  user_id: 2,
  company_id: 1,
  moa_id: 1,
}]

ppsps.each do |ppsp|
  p = Ppsp.create(address: ppsp[:address], start: ppsp[:start], end: ppsp[:end], nature: ppsp[:nature], workforce: ppsp[:workforce], 
  user_id: ppsp[:user_id], company_id: ppsp[:company_id], moa_id: ppsp[:moa_id])
  p "create #{p.id} PPSP"
end
