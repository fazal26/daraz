Role.create!([
    {name: "admin"},
    {name: "seller"},
    {name: "buyer"},
    {name: "guest"},
])

user = User.new({
    email: "admin@admin.com",
    username: "Super Cool Admin",
    password: "pppppp",
    password_confirmation: "pppppp"
})

user.add_role(:admin)
user.save!

user1 = User.create!({email: "user1@test.com", username: "user1", password: "pass1234$", password_confirmation: "pass1234$"})

user2 = User.create!({email: "user2@test.com", username: "user2", password: "pass1234$", password_confirmation: "pass1234$"})

user3 = User.create!({email: "user3@test.com", username: "user3", password: "pass1234$", password_confirmation: "pass1234$"})

milkpak = user2.products.create(title: 'milkpak', quantity: 100, description: 'nestle milk', price: 100.00)

custard = user2.products.create(title: 'custard', quantity: 100, description: 'nestle custard', price: 60.00)

cheese = user1.products.create(title: 'cheese', quantity: 100, description: 'nestle cheeese', price: 160.00)

cooper = user1.products.create(title: 'cooper', quantity: 100, description: 'nestle cooper', price: 160.00)

laptop = user3.products.create(title: 'laptop', quantity: 30, description: 'lenovo laptop', price: 160000.00)