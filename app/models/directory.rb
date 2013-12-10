class Directory < ActiveRecord::Base
  has_ancestry
  belongs_to :site
  has_many :pages

  def to_s
    name
  end
end
