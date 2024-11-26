module Authorization
  extend ActiveSupport::Concern

  private

    def authorize_if(value)
      raise UnauthorizedError unless value
    end

end

class UnauthorizedError < StandardError
end