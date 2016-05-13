Kaminari.configure do |config|
  if Rails.env.test?
    config.default_per_page = 3
  else
    config.default_per_page = 10
  end
end
