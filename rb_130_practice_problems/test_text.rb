# Test file for `text.rb`

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'text' # Class we want to tesst
require_relative 'textfile2' # required text file

class TextTest < Minitest::Test

  def setup
    text = File.open('textfile2', r)
    textobj = Text.new(text)
  end

  def teardown
    

  end

end