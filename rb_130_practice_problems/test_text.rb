# Test file for `text.rb`

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'text' # Class we want to tesst
# require_relative 'textfile2.txt' # required text file

class TextTest < Minitest::Test

  def setup
    @file = File.open('./textfile2.txt', 'r')
  end

  def test_swap
    text = Text.new(@file.read)
    actual_text = text.swap('a', 'e')
    expected_text = <<~TEXT.chomp
    Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
    Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
    quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
    nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
    dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
    et verius meuris, et pheretre mi.
    TEXT

    assert_equal actual_text, expected_text
  end

  def teardown
    @file.close
  end
end