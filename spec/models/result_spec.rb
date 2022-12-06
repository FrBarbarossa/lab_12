require 'rails_helper'

RSpec.describe Result, type: :model do
  let! (:correct_number) { 25 }
  let! (:correct_number_not_in_results) { 15 }
  let! (:incorrect_number) { -10 }
  let! (:incorrect_symbol) { "asdsa" }
  let! (:correct_result_with_correct_number) { [[1, 1], [2, 4], [3, 9], [11, 121], [22, 484]] }
  let (:some_correct_input) { Result.create!({input: correct_number}) }
  let (:some_correct_input_clone) { Result.create!({input: correct_number}) }
  let (:some_incorrect_number_input) { Result.new({input: incorrect_number}) }
  let (:some_incorrect_symbol_input) { Result.new({input: incorrect_symbol}) }

  it "has calculates correctly" do
    expect(some_correct_input.result).to eq correct_result_with_correct_number
  end

  it "has record after create with correct input" do
    some_correct_input
    expect(described_class.find_by(input: correct_number).result).to eq correct_result_with_correct_number
  end 

  it "has no record while record is not created" do
    expect(described_class.find_by(input: correct_number_not_in_results)).to eq nil
  end

  it "returns error when incorrect number given" do
    expect(some_incorrect_number_input.valid?).to eq false
    expect(some_incorrect_number_input.errors.size).to be > 0
  end

  it "returns error when symbol given" do
    expect(some_incorrect_symbol_input.valid?).to eq false
    expect(some_incorrect_symbol_input.errors.size).to be > 0
  end

end