require 'spec_helper'

describe 'tests/index', type: :view do
  it 'displays content' do
    render
    expect(rendered).to match /tests#index/
  end
end
