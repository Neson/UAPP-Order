module OmniAuth
  module Strategies
    autoload :Uapp, Rails.root.join('lib', 'omniauth', 'strategies', 'uapp')
  end
end
