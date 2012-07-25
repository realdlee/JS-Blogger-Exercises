module ApplicationHelper
  def d(object)
    if Rails.env == "development"
      debug object
    else
      raise "Debug code running in test & production!"
    end
  end

end
