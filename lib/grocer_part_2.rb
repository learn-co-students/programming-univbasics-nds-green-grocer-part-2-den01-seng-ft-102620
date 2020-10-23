require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  cart.each{|index|
  index.each{|key,value|
  coupons.each{|cindex|
  cindex.each{|ckey,cvalue|
    if key == ckey && value == cvalue && cindex[:num] <= index[:count]
      
      cart[cart.length] = {}
      cart[cart.length-1][:item] = index[:item] + " W/COUPON"
      cart[cart.length-1][:price] = cindex[:cost]/cindex[:num]
      cart[cart.length-1][:clearance] = index[:clearance]
      cart[cart.length-1][:count] = cindex[:num]
      index[:count] -= cindex[:num]
    end
  }
  }
  }
  }
end

def apply_clearance(cart)
  cart.each{|index|
  if index[:clearance] == true
  index[:price] = (index[:price]*0.8).round(2)
  end
  }
end

def checkout(cart, coupons)
   current_bill = 0
   count =0
  
  
 
 
  apply_clearance( apply_coupons(consolidate_cart(cart),coupons)).each{|index|

  current_bill += (index[:price]*index[:count])


 }
 if current_bill >= 100
   current_bill = current_bill * 0.9
 end
current_bill
end
