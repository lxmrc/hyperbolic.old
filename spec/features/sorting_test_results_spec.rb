require 'rails_helper'

RSpec.feature "Sorting test results", type: :feature do
  let(:exercise) { FactoryBot.create(:exercise, test_file: Rack::Test::UploadedFile.new("./spec/fixtures/test_result_order_test.rb")) }

  scenario "sorted test results", js: true do
    visit new_exercise_iteration_path(exercise.id)
    fill_in_editor_field "1"
    click_button "Run"
    expect(all(".test-result").map { |li| li["id"] }).to eq(["test_one", "test_two", "test_three"])
  end

  private

  def fill_in_editor_field(text)
    within all(".CodeMirror")[0] do
      current_scope.click
      field = current_scope.find("textarea", visible: false)
      field.send_keys text
    end
  end
end
