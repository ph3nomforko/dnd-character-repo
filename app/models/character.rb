class Character < ActiveRecord::Base

    validates :character_name, presence: true
    validates :character_class, presence: true
    validates :species, presence: true
    validates :level, presence: true

    belongs_to :user
    
end
