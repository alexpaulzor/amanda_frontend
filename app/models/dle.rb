class Dle < ActiveRecord::Base
  belongs_to :amanda_config
  has_many :dle_runs
end
