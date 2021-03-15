class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def dig(key)
    send(:[], key)
  end
end
