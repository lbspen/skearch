require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.default_selector = :xpath
Capybara.ignore_hidden_elements = false
Capybara.match = :prefer_exact
