require 'rubygems'
require 'headless'
require 'selenium-webdriver'

headless = Headless.new
headless.start
headless.video.start_capture
driver = Selenium::WebDriver.for :chrome
driver.navigate.to 'http://google.com'
element = driver.find_element(:name, 'q')
element.send_keys "Hello WebDriver!"
element.submit

puts driver.title
headless.video.stop_and_save("./result.mov")

#headless.destroy
