require 'rubygems'  
require 'active_record'  
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => "localhost",  
:database => "mass_opinion"  
)  
  
class User < ActiveRecord::Base  
   has_many :questionnaires, :dependent => :destroy
   has_many :comments, :dependent => :destroy
end  

class Questionnaire < ActiveRecord::Base
   belongs_to :user
   has_many :comments, :dependent => :destroy
   has_many :options, :dependent => :destroy
   has_and_belongs_to_many :categories
end

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :questionnaire
end

class Option < ActiveRecord::Base
   belongs_to :questionnaire
end

class Category < ActiveRecord::Base
   has_and_belongs_to_many :questionnaires
end
User.create(:name => 'Davenkin', :password => 'Davenkin', :email => "davenkin@163.com", :register_date =>'2011-02-02') 
user = User.find(:first) # returns the first object fetched by SELECT * FROM rubyists  
user.questionnaires.create(:name => 'Do you like programming?', :post_date => Time.now)
user.questionnaires.create(:name => 'Do you like ruby?', :post_date => Time.now)
Category.create(:name => 'computer')
category = Category.find(:first)
questionnaire = Questionnaire.find(:first)
questionnaire_last = Questionnaire.find(:last)
questionnaire.categories << category
category.questionnaires << questionnaire_last
questionnaire.options.create(:content => 'Yes')
questionnaire.options.create(:content => 'No')
questionnaire.options.create(:content => 'Hard to say')
option = Option.find(:first)
puts option.questionnaire.id
user.comments.create(:content => "Yes, I like it.", :post_date => Time.now, :questionnaire_id => questionnaire.id )
questionnaire.comments.create(:content => "No, I do not like it.", :post_date => Time.now, :user_id => user.id )
Comment.create(:content => "Um, it hard to say.", :post_date => Time.now, :user_id => user.id,  :questionnaire_id => questionnaire.id )
puts %{#{user.name} email: #{user.email}} 
#user.destroy