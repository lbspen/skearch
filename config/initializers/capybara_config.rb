require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
    :debug => true,
    :inspector => true,
    :js_errors => false,
    :timeout => 100
  })
end
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.default_selector = :xpath
Capybara.ignore_hidden_elements = false
Capybara.match = :prefer_exact
