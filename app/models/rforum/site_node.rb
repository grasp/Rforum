# coding: utf-8
class Rforum::SiteNode
  include Mongoid::Document
  include Mongoid::BaseModel

  field :name
  field :sites_count, :type => Integer
  field :sort, :type => Integer, :default => 0
  has_many :sites,:class_name=>"Rforum::Site"

  validates_presence_of :name
  validates_uniqueness_of :name
end
