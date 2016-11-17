module Searchable
  extend ActiveSupport::Concern
  included do
    scope :name_contains, ->(chars) { where('name LIKE ?', "%#{chars}%") }
  end
end
