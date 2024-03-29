# These are all objects:

# Class
# Module
# Method
# Object.new
# "a string"
# 42
# lambda { puts "This is a block of code. An object!"}
# SomeUserDefinedClass.new

# Here is an exercise that you can solve using the class method. 
# I have a couple of dishes - Soup, IceCream and ChineseGreenBeans (yum!). 
# Objects of these classes can be added to the DeliveryTray.
# The DeliveryTray has to keep track of the number of dish of each type and suggest how many dishes it needs to carry.

class Food
end
 
class Soup < Food
end
class IceCream < Food
end
class ChineseGreenBeans < Food
end
 
class DeliveryTray
  FOOD_DISH_MAPPING = {
    Soup => "soup bowl",
    IceCream => "ice cream bowl",
    ChineseGreenBeans => "serving plate"
  }
 
  def initialize
    @dishes_needed = {}
  end
 
  def add(food)
    dish = FOOD_DISH_MAPPING[food.class]
    @dishes_needed[dish] = (@dishes_needed[dish] || 0) + 1
  end
 
  def dishes_needed
    return "None." if @dishes_needed.empty?
 
    @dishes_needed.map {|dish_name, count| "#{count} #{dish_name}" }.join(", ")
  end
end
 
 
d=DeliveryTray.new
d.add Soup.new; d.add Soup.new
d.add IceCream.new
puts d.dishes_needed # should be "2 soup bowl, 1 ice cream bowl"

# Now can you implement a method superclasses inside Object that returns this class hierarchy information? 
# The method has to return an array that lists the superclasses of the current object.

class Object
  def superclasses(klass = self.superclass)
    return [] if klass.nil?
    [klass] + superclasses(klass.superclass)
  end
end
 
class Bar
end
 
class Foo < Bar
end
 
p Foo.superclasses  # should be [Bar, Object, BasicObject]
 
# In summary:

# Objects in Ruby only store the state. Its behaviour comes from its class definition.
# Objects can also have methods that are independent of the parent class definition. 
# They are called singleton methods and are stored on the metaclass of the object. 
# The metaclass is typically invisible to the programmer.

# Ruby 1.9 introduced the singleton_class as a shorthand for the class << self syntax we saw earlier. 
# From now on, you can just call the singleton_class instead of our custom metaclass method.

class Object  
  def singleton_method?(method)
    singleton_methods = 
      self.singleton_class.instance_methods - self.class.instance_methods
        
    singleton_methods.include? method
  end
end
 
 
foo = "A string"
def foo.shout
  puts foo.upcase
end
 
# shout is a singleton method.
p foo.singleton_method?(:shout)

# Cloning and freezing objects

# Let us finish this chapter with a trivial exercise. 
# Add a method frozen_clone to the Object class so that I can get a frozen clone of any object.

class Object
  def frozen_clone
    # your code here
    self.clone.freeze
  end
end