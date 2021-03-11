class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def with(data)
    assign_attributes(data)
    self
  end
end
