# Test file for cash_register class

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'cash_register' # Class we want to test
require_relative 'transaction' # Class required for `cash_register` to be tested.

class CashRegisterTest < MiniTest::Test

  def setup
    @transaction1 = Transaction.new(100)
    @transaction1.amount_paid=(100)
    @register = CashRegister.new(1000)
  end

  def test_accept_money
    @register.accept_money(@transaction1)
    assert_equal(1100, @register.total_money)
  end

  def test_accept_money2 # To setup objects within test
    register = CashRegister.new(1000)
    transaction = Transaction.new(20)
    transaction.amount_paid = 20

    previous_amount = register.total_money
    register.accept_money(transaction)
    current_amount = register.total_money

    assert_equal previous_amount + 20, current_amount
  end

  def test_change
    assert_equal(0, @register.change(@transaction1))
  end

  def test_change1 # Setting up the object within the test, and ensuring change is given.
    register = CashRegister.new(100)
    transaction = Transaction.new(100)
    transaction.amount_paid = 110

    assert_equal(10, register.change(transaction))
  end

  def test_give_receipt
    register = CashRegister.new(100)
    transaction = Transaction.new(10)

    assert_output("You've paid $#{10}.\n") { register.give_receipt(transaction) }
  end

  def test_give_receipt1
    item_cost = 35
    register = CashRegister.new(1000)
    transaction = Transaction.new(item_cost)
    assert_output("You've paid $#{item_cost}.\n") { register.give_receipt(transaction)}
  end

  def test_prompt_for_payment
    fullcost = StringIO.new("35\n") # Using StringIO to simulate keyboard entry for testing.
    output = StringIO.new
    item_cost = 35
    transaction = Transaction.new(item_cost)
    transaction.prompt_for_payment(input: fullcost, output: output)
    assert_equal(35, transaction.amount_paid)
  end

  # Extras

  def test_transaction_item_cost
    transaction = Transaction.new(100)
    assert_equal(100, transaction.item_cost)
  end
end