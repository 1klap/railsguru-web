class RequestLog < ApplicationRecord
  belongs_to :user, optional: true
end
