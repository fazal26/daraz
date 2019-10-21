Role.create!([{name: "admin"}, {name: "seller"}, {name: "buyer"}, {name: "guest"}])
user0 = User.new({email: "admin@admin.com", username: "super admin", password: "pass1234$", password_confirmation: "pass1234$"})
user0.add_role(:admin)
user0.save!
user1 = User.new({email: "user1@seller.com", username: "user1", password: "pass1234$", password_confirmation: "pass1234$"})
user1.add_role(:seller)
user1.save!
user11 = User.new({email: "user2@seller.com", username: "user2", password: "pass1234$", password_confirmation: "pass1234$"})
user11.add_role(:seller)
user11.save!
user2 = User.new({email: "user1@buyer.com", username: "user3", password: "pass1234$", password_confirmation: "pass1234$"})
user2.add_role(:buyer)
user2.save!
user3 = User.new({email: "user2@buyer.com", username: "user4", password: "pass1234$", password_confirmation: "pass1234$"})
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

require 'open-uri'

# doc = Nokogiri::HTML(open('https://homeshopping.pk/categories/Mobile-Phones-Price-Pakistan'))
# doc.xpath('//div[contains(@class, "product-box")]/div[@class="pad15"]').each do |product|
#     img = product.xpath('a/figure/img/@data-src').text
#     title = product.xpath('h5[@class="ProductDetails"]/a').text
#     price = product.xpath('div/a[@class="price"]').text
#     price = price.sub(/^../, '').tr(',', '').to_f
#     new_product = User.find_by(email: "user1@seller.com").products.create(title: title, price: price, description: title)
#     downloaded_image = open(img)
#     new_product.images.attach(io: downloaded_image  , filename: title + '-img')
#     new_product.save
# end

page = HTTParty.get('https://www.casiocentre.com/product-category/standard-male/?count=100&paged=')
doc = Nokogiri::HTML(page)
description = "Lorem ipsum dolor sit amet, amet repudiare sed ad. Urbanitas intellegat vix ea. Cum eu pertinax reprimique, in nec eius eruditi legimus. Hinc laoreet pri ut, pro dicat perfecto ad, eu sed tacimates nominati definitionem. In legere maiorum salutandi vim, ex mea natum errem.

No vix illum consetetur reformidans. Vim eu movet dolorem. Tritani accumsan scripserit ius cu, vim saperet labores an. Has fastidii insolens electram no, sea ut choro aliquando scriptorem.

Dolorem constituto sit cu, ei pro liberavisse concludaturque. Blandit efficiendi conclusionemque sed in, pro ut alia facilis. Mel at elit antiopam. Illum denique eos in, civibus mediocritatem ad has. Vel ad labore nostrum. In zril prompta duo. Ne vis movet eligendi."

doc.xpath('//div[@class="archive-products"]/ul/li').each do |product|
    img = product.xpath('div[@class="product-image"]/a//div[@class="inner"]/img/@src').text
    title = product.xpath('a[@class="product-loop-title"]/h3').text
    price = product.xpath('span[@class="price"]/span').text
    price = price.sub(/^.../, '').tr(',', '').to_f
    new_product = User.find_by(email: "user2@seller.com").products.create(title: title, price: price, description: description, quantity: 1)
    downloaded_image = open(img)
    new_product.images.attach(io: downloaded_image  , filename: title + '-img')
    new_product.save
end
