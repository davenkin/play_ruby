require 'rubygems'
require 'headless'
require 'selenium-webdriver'

headless = Headless.new
headless.start
headless.video.start_capture
driver = Selenium::WebDriver.for :firefox
driver.navigate.to 'http://google.com'
puts driver.title
headless.video.stop_and_save("result.mov")

headless.destroy
