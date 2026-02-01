class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  ACCOUNT_STOP_TIME = 100
end
