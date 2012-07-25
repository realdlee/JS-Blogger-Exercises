class Article < ActiveRecord::Base
  attr_accessible :title, :body, :tag_list, :image

  has_many :comments
  has_many :taggings
  has_many :tags, :through => :taggings

  before_save :word_count  #must have this to call function
  
  has_attached_file :image

  def self.ordered_by(param)
    case param
      when 'word_count' then Article.order('word_count')
      when 'title'      then Article.order('title')
      when 'published'  then Article.order('created_at DESC')
      else Article.all
    end
  end
  
  def tag_list
    return self.tags.join(", ")
  end

  def tag_list=(tags_string)
    self.taggings.destroy_all

    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq

    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by_name(tag_name)
      tagging = self.taggings.new
      tagging.tag_id = tag.id
    end
  end
  
  private 
  
  def word_count
    self.word_count = self.body.split(" ").count
  end
  
end
