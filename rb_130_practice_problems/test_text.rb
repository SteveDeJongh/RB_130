# Test file for `text.rb`

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'text' # Class we want to tesst
# require_relative 'textfile2.txt' # required text file

class TextTest < Minitest::Test

  def setup
    @file = File.open('./textfile2.txt', 'r') # Opening the file for reading, and assigning the file object to an instance variable `@file`
  end

  def test_swap
    text = Text.new(@file.read) # Creating an instance of the class text, and passing it the text we want to work on.
    actual_text = text.swap('a', 'e') # Using our `text::swap` method to return converted text.
    expected_text = <<~TEXT.chomp
    Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
    Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
    quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
    nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
    dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
    et verius meuris, et pheretre mi.
    TEXT

    assert_equal actual_text, expected_text # checking if converted text from `swap` method matches expected text.
  end

  def test_word_count
    text = Text.new(@file.read)
    assert_equal 72, text.word_count
  end

  def teardown
    @file.close
    puts "File has been closed: #{@file.closed?}."
  end
end