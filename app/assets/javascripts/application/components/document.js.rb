# We need a class that inherits from FerroDocument.
# This is the staring point for any Ferro application.
class Document < Ferro::Document

  # The cascade method is called after the Document
  # has been created and is ready to create child
  # objects.
  # Here we have just one child 'main'. It mostly
  # serves to add some structure to the object
  # hierarchy we are creating and to attach some
  # CSS rules.
  #
  # Want to add you own components? I have
  # left some commented code to add a menu
  # as an example to get you started.
  def cascade
    add_child :main, Main
    # add_child :menu, Menu
  end
end

class Main < Ferro::Component::Article

  # Every Ferro class will add two css classes to the
  # related DOM object. So the main object will
  # have css classes 'main' and 'ferro-element-article'.
  def cascade
    add_child :todo, Todo
  end
end

# # An example for setting up a menu
# # You still need to setup the Ferro router to make
# # menu clicks do something meaningful.
# class Menu < Ferro::Component::Navigation

#   def cascade
#     add_child :items, Ferro::Element::List

#     3.times.each do |i|
#       add_item "Option #{i+1}", "option_#{i+1}"
#     end
#   end

#   def add_item(content, href)
#     items.add_item MenuItem, content: content, href: href
#   end
# end

# class MenuItem < Ferro::Element::ListItem

#   def before_create
#     @content = option_replace :content
#     @href    = option_replace :href
#   end

#   def cascade
#     add_child :link, Ferro::Element::Anchor, content: @content, href: @href
#   end
# end