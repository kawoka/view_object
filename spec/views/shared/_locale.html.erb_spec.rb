require 'spec_helper'

describe 'shared/locale', type: :view do
  it 'show locale' do
    render 'shared/locale', test: 'its test locale'
    expect(rendered).to match /its test locale/
  end
end
