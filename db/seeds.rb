# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: '1@1',password: '123456')
# Genre.create([{name: 'ケーキ'}, {name: 'プリン'}, {name: '焼き菓子'}, {name: 'キャンディ'}])
# Customer.create([{last_name: '1', first_name: '1', last_name_kana: '1', first_name_kana: '1', email: '1@1', password: '123456', post_code: '1234567', address: '1', telephone_number: '1234567890'}, {last_name: '2', first_name: '2', last_name_kana: '2', first_name_kana: '2', email: '2@2', password: '123456', post_code: '1234567', address: '2', telephone_number: '1234567890'}])
# Address.create([{customer_id: '1', name: '1a', post_code: '1234567', address: '11'}, {customer_id: '1', name: '1b', post_code: '1234567', address: '12'}])
# Item.create([{genre_id: '1', name: 'チョコケーキ', introduction: 'おいしいチョコケーキです。', price: '100'}, {genre_id: '1', name: 'チーズケーキ', introduction: 'おいしいチーズケーキです。', price: '200'}])
# CartItem.create([{item_id: '1', customer_id: '1', amount: '1'}, {item_id: '2', customer_id: '1', amount: '2'}])
# Order.create([{customer_id: '1', post_code: '1234567', address: '11', name: '1a', shipping_cost: '800', total_payment: '1000', payment_method: 'credit_card'}, {customer_id: '1', post_code: '1234567', address: '12', name: '1b', shipping_cost: '800', total_payment: '2000', payment_method: 'transfer'}])
# OrderDetail.create([{order_id: '1', item_id: '1', price: '110', amount: '1'}, {order_id: '1', item_id: '2', price: '220', amount: '2'}])