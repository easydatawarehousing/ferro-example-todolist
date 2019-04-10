# The todo component
# This defines all the needed parts (except todo items) and defines some helper methods.
class Todo < Ferro::Component::Base

  def cascade
    add_child :title,  Ferro::Element::Text, size: 4, content: 'Todo list'
    add_child :entry,  TodoEntry, button_text: 'Add', placeholder: 'New item ...'
    add_child :status, TodoStatus
    add_child :list,   TodoList

    update_status
  end

  def update_status
    status.update_status
  end

  def add_list_item(value)
    list.add_item value
    update_status
  end

  def clear_list
    list.clear
  end
end

# Text input and button, this is easy since we can use a ready made Ferro
# component. We only need to implement its 'submitted' method.
class TodoEntry < Ferro::Combo::Search

  def submitted(value)
    # Todo inherits from Ferro::Component::Base. This means that all children
    # of Todo can reach the Todo instance using the 'component' method.
    component.add_list_item value
  end
end

# The status bar, just a text to show a count of items and a 'clear' link.
class TodoStatus < Ferro::Element::Block

  def cascade
    add_child :info,  Ferro::Element::Text
    add_child :clear, TodoStatusClear, content: '[clear]', href: ''
  end

  def update_status
    info.set_text "#{component.list.open_items} of #{component.list.total_items} remaining"
  end
end

class TodoStatusClear < Ferro::Element::Anchor

  def clicked
    component.clear_list
  end
end

# The list to hold and manage the todo items.
class TodoList < Ferro::Form::Base

  def cascade
    # We are keeping track of the todo-items ourselves
    @list = []

    # Every todo-item needs to have a unique name since
    # Ferro lements keeps track of their children via
    # that name. Call '@id.next' to generate a unique name.
    @id = Ferro::Sequence.new 'item_'

    # Add 3 example items
    [
      'Learn Ruby',
      'Learn Ferro',
      'Create first NoHTML website',
    ].each do |name|
      add_item(name)
    end
  end

  def add_item(name)
    label = name.strip

    if !label.empty?
      @list << add_child(@id.next, TodoItem, content: label)
    end
  end

  def clear
    @list.delete_if do |item|
      item.destroy if item.checked?
    end

    component.update_status
  end

  def open_items
    @list.select { |item| !item.checked? }.length
  end

  def total_items
    @list.length
  end
end

# Todo item: a checkbox with a label.
class TodoItem < Ferro::Element::Block

  def before_create
    @content = option_replace :content
  end

  def cascade
    add_child :cb,      TodoCheckBox
    add_child :content, TodoLabel, content: @content, for: cb.dom_id
  end

  def toggle_content(completed)
    content.update_state(:completed, completed)
    component.update_status
  end

  def checked?
    cb.checked?
  end
end

class TodoCheckBox < Ferro::Form::CheckBox

  def clicked
    parent.toggle_content checked?
  end
end

class TodoLabel < Ferro::Form::Label

  def after_create
    # A state is a boolean flag that you can add to any Ferro class.
    # If it has a true state Ferro will add a CSS class with the same
    # name to the related DOM element. In this case there is a CSS
    # rule (.completed) for the strike-through effect.
    add_state :completed
  end
end