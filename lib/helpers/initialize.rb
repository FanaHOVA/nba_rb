module Initializable
  def initialize(params = {})
    params.each { |key, value| send "#{key}=", value }
  end
end
