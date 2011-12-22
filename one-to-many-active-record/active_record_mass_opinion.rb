require 'rubygems'  
require 'active_record'  
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => "localhost",  
:database => "one_to_many"
)  


class Category < ActiveRecord::Base
   has_many :books
end

class Book < ActiveRecord::Base
  belongs_to :category
end

Category.create(:name => 'computer')
Category.create(:name => 'language')
category = Category.find(:first)
category.books.create(:name => 'Programming Ruby')
category.books.create(:name => 'Programming Java')
category_last = Category.find(:last)
category_last.books.create(:name => 'Learning English')
category_last.books.create(:name => 'French in 30 days')

book = Book.find(:first)
puts %{#{book.name} belongs to category: #{book.category.name}}
