require 'rubygems'
require 'active_record'
ActiveRecord::Base.establish_connection(
    :adapter => "mysql",
    :host => "localhost",
    :database => "mass_opinion"
)

class User < ActiveRecord::Base
  has_many :questionnaires, :dependent => :destroy

  def create_questionnaire(name)
    questionnaires.create(:name => name, :post_date => Time.now)
  end

  def delete_questionnaire(questionnaire_id)
    questionnaire_ids = questionnaires.collect { |e| e.id }
    Questionnaire.destroy(questionnaire_id) if questionnaire_ids.include? questionnaire_id
  end

end

class Questionnaire < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :options, :dependent => :destroy
  has_and_belongs_to_many :categories

  def self.find_by_category(category_content)
    result = Array.new
    all.each do |questionnaire|
      category_contents = questionnaire.categories.collect { |e| e.name }
      result << questionnaire if category_contents.include? category_content
    end
    result
  end

end

class Comment < ActiveRecord::Base
  belongs_to :questionnaire

  def add_to_questionnaire(questionnaire_id)
    self.questionnaire_id = questionnaire_id
    self.save
  end

end

class Option < ActiveRecord::Base
  belongs_to :questionnaire

  def vote
    self.vote_count += 1
    self.save
  end

end

class Category < ActiveRecord::Base
  has_and_belongs_to_many :questionnaires

  def attach_to_questionnaire(questionnaire_id)
    questionnaires << Questionnaire.find(questionnaire_id)
  end
end

User.create(:name => 'Davenkin', :password => 'Davenkin', :email => "davenkin@163.com", :register_date =>'2011-02-02')
user = User.find(:first) # returns the first object fetched by SELECT * FROM rubyists  
user.questionnaires.create(:name => 'Do you like programming?', :post_date => Time.now)
user.questionnaires.create(:name => 'Do you like ruby?', :post_date => Time.now)
Category.create(:name => 'computer')
Category.create(:name => 'ruby')
category = Category.find(:first)
category_last = Category.find(:last)
questionnaire = Questionnaire.find(:first)
questionnaire_last = Questionnaire.find(:last)
category_last.attach_to_questionnaire(questionnaire_last.id)
questionnaire.categories << category
category.questionnaires << questionnaire_last
questionnaire.options.create(:content => 'Yes')
questionnaire.options.create(:content => 'No')
questionnaire.options.create(:content => 'Hard to say')
option = Option.find(:first)
option.vote
questionnaire.comments.create(:content => "No, I do not like it.", :post_date => Time.now)
Comment.create(:content => "Um, it hard to say.", :post_date => Time.now, :questionnaire_id => questionnaire.id)
puts %{#{user.name} email: #{user.email}}
comment = Comment.new(:content => 'something to say', :post_date => Time.now)
comment.add_to_questionnaire(questionnaire_last.id)
selected_questionnaires = Questionnaire.find_by_category('computer')
selected_questionnaires.each {|e| puts e.name}