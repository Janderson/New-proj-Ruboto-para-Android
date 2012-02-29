require 'ruboto/activity'
require 'ruboto/widget'
require 'ruboto/util/toast'


ruboto_import_widgets :Button, :LinearLayout, :TextView, :EditText

$activity.start_ruboto_activity "$sample_activity" do
  setTitle 'This is the Title'

  def on_create(bundle)
    self.content_view = linear_layout(:orientation => :vertical) do
          @text_view = text_view :text => 'o que esta fazendo aqui?', :id => 42
          button :text => 'M-x butterfly', :width => :wrap_content, :id => 43, :on_click_listener => @handle_click
          outer_ll = LinearLayout.new($activity)
          outer_ll.orientation = LinearLayout::VERTICAL
          outer_ll.set_padding 5, 5, 5, 5
          
          # The inner layout will sit at the top of the outer layout
          inner_ll = LinearLayout.new($activity)
          outer_ll.add_view inner_ll 
          params = inner_ll.get_layout_params
          params.width = ViewGroup::LayoutParams::FILL_PARENT
          params.height = ViewGroup::LayoutParams::WRAP_CONTENT
          
          # The search EditText will sit to the left of the inner layout
          search_et = EditText.new($activity)
          search_et.single_line = true
          search_et.hint = "Enter search criteria"
          inner_ll.add_view search_et
          params = search_et.get_layout_params
          params.width = ViewGroup::LayoutParams::FILL_PARENT
          params.height = ViewGroup::LayoutParams::WRAP_CONTENT
          params.weight = 1.0
          
          # The search Button will sit to the right of the inner layout
          search_b = Button.new($activity)
          search_b.text = "Search"
          search_b.on_click_listener = proc{|view| search_et.text = "do_something"} 
          inner_ll.add_view search_b
          params = search_b.get_layout_params
          params.width = ViewGroup::LayoutParams::WRAP_CONTENT
          params.height = ViewGroup::LayoutParams::WRAP_CONTENT
          
          # The results ListView will sit below the inner layout
          results_lv = ListView.new($activity)
          ## Set up the ListView contents
          outer_ll.add_view results_lv
          params = results_lv.get_layout_params
          params.width = ViewGroup::LayoutParams::FILL_PARENT
          params.height = ViewGroup::LayoutParams::FILL_PARENT
          params.weight = 1.0
    end
  end

  @handle_click = proc do |view|
      @text_view.text = 'What hath Matz wrought!'
      toast 'Voce clicou no botao'
  end
end
