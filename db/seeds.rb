require_relative "../app/models/user.rb"

#USERS
User.create(username: "mum")
User.create(username: "dad")
User.create(username: "bro")
User.create(username: "sis")

#PRODUCTS
Product.create(name: "Luxe Round Side Table", url: "oliverbonas.com/furniture/luxe-round-side-table-34501", price: 195.00, delivery_in_days: 28)
Product.create(name: "The Photograph as Contemporary Art", url: "amazon.co.uk/Photograph-Contemporary-Art-World/dp/0500204187", price: 11.31, delivery_in_days: 14)
Product.create(name: "No7 Protect & Perfect Intense ADVANCED Facial Suncare SPF50+", url: "boots.com/no7-protect-and-perfect-intense-facial-sun-protection-spf-50-50ml-10175459#2C0syp3Fh5pIYeEm.99", price: 15.00, delivery_in_days: 2)
Product.create(name: "Hidden button shirt dress", url: "monki.com/en_gbp/clothing/view-all-clothing/product.hidden-button-shirt-dress-rusty-orange.0638581006.html", price: 40.00, delivery_in_days: 7)
Product.create(name: "Aria DAB/DAB+/FM Bluetooth Radio", url: "johnlewis.com/john-lewis-partners-aria-dab-dab-fm-bluetooth-radio/p3356839", price: 89.00, delivery_in_days: 3)
Product.create(name: "Dell Inspiron 14 5480 laptop", url: "johnlewis.com/dell-inspiron-14-5480-laptop-intel-core-i5-processor-8gb-ram-256gb-ssd-14-inch-full-hd-silver/p3911288", price: 569.99, delivery_in_days: 3)
Product.create(name: "Modern Rarity Diamond Mini Link Chain Bracelet", url: "johnlewis.com/modern-rarity-diamond-mini-link-chain-bracelet/p3909199", price: 130.00, delivery_in_days: 2)
Product.create(name: "Charlotte Tilbury Matte Revolution Lipstick", url: "johnlewis.com/charlotte-tilbury-matte-revolution-lipstick/p2133412", price: 24.00, delivery_in_days: 2)
Product.create(name: "2018 Apple iPad 9.7", url: "johnlewis.com/2018-apple-ipad-9-7-inch-a10-ios-11-wi-fi-32gb/gold/p2999393", price: 319.00, delivery_in_days: 2)
Product.create(name: "Flower Dog Collar for Weddings", url: "etsy.com/uk/listing/237401445/flower-dog-collar-for-weddings-pastel", price: 33.95, delivery_in_days: 5)
Product.create(name: "Frank Ocean Poster", url: "etsy.com/uk/listing/549512713/frank-ocean-poster-minimal-poster-frank", price: 10.45, delivery_in_days: 2)
Product.create(name: "Berghaus Peak 3.1 Festival Tent", url: "ebay.co.uk/itm/New-Berghaus-Peak-3-1-Festival-Tent-Camping-Equipment/133044465405", price: 72.95, delivery_in_days: 5)
Product.create(name: "Sapphire, Diamond & Pearl Bee Brooch", url: "thefinejewellerycompany.com/pearl-sapphire-diamond-bee-brooch-170535", price: 395.00, delivery_in_days: 2)
Product.create(name: "The Lego Movie Videogame", url: "game.co.uk/en/the-lego-movie-videogame-270359#new", price: 19.99, delivery_in_days: 2)
Product.create(name: "Smeg Dolce & Gabbana 2-Slice Toaster", url: "johnlewis.com/smeg-dolce-gabbana-2-slice-toaster/p3513639", price: 499.95, delivery_in_days: 5)

#WISHES
Wish.create(quantity: 1, occasion: "Birthday", user_id: 1, product_id: 1)
Wish.create(quantity: 1, occasion: "Birthday", user_id: 1, product_id: 2)
Wish.create(quantity: 1, occasion: "Birthday", user_id: 1, product_id: 3)
Wish.create(quantity: 1, occasion: "Anniversary", user_id: 1, product_id: 4)
Wish.create(quantity: 1, occasion: "Birthday", user_id: 2, product_id: 5)
Wish.create(quantity: 1, occasion: "Birthday", user_id: 2, product_id: 6)
Wish.create(quantity: 1, occasion: "Anniversary", user_id: 2, product_id: 9)
Wish.create(quantity: 1, occasion: "Birthday", user_id: 3, product_id: 11)
Wish.create(quantity: 1, occasion: "Birthday", user_id: 3, product_id: 12)
Wish.create(quantity: 1, occasion: "Birthday", user_id: 3, product_id: 14)
Wish.create(quantity: 1, occasion: "Birthday", user_id: 4, product_id: 7)
Wish.create(quantity: 1, occasion: "Birthday", user_id: 4, product_id: 8)
Wish.create(quantity: 1, occasion: "Wedding", user_id: 4, product_id: 13)
Wish.create(quantity: 5, occasion: "Wedding", user_id: 4, product_id: 10)
Wish.create(quantity: 1, occasion: "Wedding", user_id: 4, product_id: 14)
