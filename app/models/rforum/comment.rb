# coding: utf-8
class Rforum::Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::SoftDelete
  include Mongoid::MarkdownBody

  field :body
  field :body_html

  belongs_to :commentable, :polymorphic => true
  belongs_to :user,:class_name=>"Ruser::User"

  attr_accessible :commentable_type, :commentable_id, :body

  index :user_id
  index :commentable_type
  index :commentable_id

  validates_presence_of :body

  before_create :fix_commentable_id
  def fix_commentable_id
    self.commentable_id = self.commentable_id.to_i
  end

  after_create :increase_counter_cache
  def increase_counter_cache
    return if self.commentable.blank?
    self.commentable.inc(:comments_count,1)
  end

  before_destroy :decrease_counter_cache
  def decrease_counter_cache
    return if self.commentable.blank?
    self.commentable.inc(:comments_count,-1)
  end

end
