require 'spec_helper'



describe "Creating todo list" do
  def create_todo_list(options={})
   options[:title] ||= "My to do list"
   options[:description] ||="This is my to do list dectiption"
   visit "/todo_lists"
   click_link "New Todo list"
   expect(page).to have_content("New todo_list")

   fill_in "Title", with: options[:title]
   fill_in "Description", with: options[:description]
   click_button "Create Todo list"     
  end
   it "redirects to the todo list index page on success" do
	create_todo_list
	expect(page).to have_content("My todo list")
	end
    it "Displays an error when the todo list has no title" do
	create_todo_list title: ""
	expect(page).to have_content("error")
	expect(TodoList.count).to eq(0)
	visit "/todo_lists"
	expect(page).to_not have_content("This is what I'm doing today")
	end

    it "Displays an error when the todo list has fewer that three characters" do
	create_todo_list title: "hi"
	expect(TodoList.count).to eq(0)
	expect(page).to have_content("error")
	expect(TodoList.count).to eq(0)
	
	visit"/todo_lists"
	expect(page).to_not have_content("This is what I'm doing today")
	end
    it "Displays an error when the todo list has no description" do
	expect(TodoList.count).to eq(0)
	create_todo_list description: "hi"
	expect(page).to have_content("error")
	expect(TodoList.count).to eq(0)
	visit"/todo_lists"
	expect(page).to_not have_content("Grocery List")
	end
    it "Displays an error when the todo list has fewer than five characters " do
	expect(TodoList.count).to eq(0)
	create_todo_list title: "Grocery List", description: "food"
	expect(page).to have_content("error")
	expect(TodoList.count).to eq(0)
	
	visit"/todo_lists"
	expect(page).to_not have_content("Grocery List")
	end
end
 
