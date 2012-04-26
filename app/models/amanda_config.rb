class AmandaConfig < ActiveRecord::Base
    has_many :tapes
    has_many :runs
    has_many :dles

    def to_s
        "#{self.name}"
    end
end
