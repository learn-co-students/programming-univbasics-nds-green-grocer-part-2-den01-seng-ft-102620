require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    coupon_item = "#{coupons[counter][:item]} W/COUPON"
    cart_coupon_item = find_item_by_name_in_collection(coupon_item, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_coupon_item
        cart_coupon_item[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_coupon_item = {
          :item => coupon_item,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[counter][:num]
        }
        cart << cart_coupon_item
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1 
  end
  cart
end

def apply_clearance(cart)
  counter = 0 
  while counter < cart.length do
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.2)).round(2) 
    end
    counter += 1  
  end
  cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  final_cart = apply_clearance(coupon_cart)
  total = 0 
  counter = 0 
  while counter < final_cart.length do 
    total += final_cart[counter][:price] * final_cart[counter][:count]
    counter += 1 
  end
  if total > 100 
    total -= (total * 0.1)
  end
  total 
end

