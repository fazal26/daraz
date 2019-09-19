# Role.create!([
#     {name: "admin"},
#     {name: "buyer"},
#     {name: "seller"}
# ])

user = User.new({email: "admin@admin.com", username: "Admin", password: "pppppp", password_confirmation: "pppppp"})

# user.add_role(:admin)
user.save!