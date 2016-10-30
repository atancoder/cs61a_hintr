class Concept < ActiveRecord::Base
    validates :name, presence: true
    validates :description, presence: true
    has_many :messages
    has_many :tag2concepts
    has_many :tags, :through => :tag2concepts
end