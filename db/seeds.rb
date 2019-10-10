Role.create!([{name: "admin"}, {name: "seller"}, {name: "buyer"}, {name: "guest"}])

user0 = User.new({email: "admin1@test.com", username: "super_admin", password: "pass1234$", password_confirmation: "pass1234$"})
user0.add_role(:admin)
user0.save!

user1 = User.new({email: "user1@test.com", username: "user1", password: "pass1234$", password_confirmation: "pass1234$"})
user1.add_role(:seller)
user1.save!

user2 = User.new({email: "user2@test.com", username: "user2", password: "pass1234$", password_confirmation: "pass1234$"})
user2.add_role(:buyer)
user2.save!

user3 = User.new({email: "user3@test.com", username: "user3", password: "pass1234$", password_confirmation: "pass1234$"})
user3.add_role(:buyer)
user3.save!

milkpak = user1.products.create(title: 'milkpak', quantity: 100, description: 'nestle milk', price: 100.00)

custard = user1.products.create(title: 'custard', quantity: 100, description: 'nestle custard', price: 60.00)

cheese = user1.products.create(title: 'cheese', quantity: 100, description: 'nestle cheeese', price: 160.00)

cooper = user1.products.create(title: 'cooper', quantity: 100, description: 'nestle cooper', price: 160.00)

laptop = user1.products.create(title: 'laptop', quantity: 30, description: 'lenovo laptop', price: 160000.00)

Coupon.create(title: 'pk30', discount: 30.0, expire_at: Date.today + 7)

Coupon.create(title: 'pk50', discount: 50.0, expire_at: Date.today + 10)

Coupon.create(title: 'pk10', discount: 10.0, expire_at: Date.today - 7)
