require 'spec_helper'

describe RegistrationForm do
  describe 'validations' do
    let(:valid_data) {
      hash = {
        email:                 'tony@example.com',
        password:              'I4mIr0nm4n',
        password_confirmation: 'I4mIr0nm4n',
      }
    }
    let(:user) { User.new }
    let(:form) { RegistrationForm.new(user) }

    specify 'valid data' do
      expect(form.validate(valid_data)).to be_true
    end

    specify 'no email' do
      valid_data[:email] = ''
      expect(form.validate(valid_data)).to be_false
    end

    specify 'email format' do
      valid_data[:email] = 'tony'
      expect(form.validate(valid_data)).to be_false
    end

    specify 'no password' do
      valid_data[:password] = ''
      expect(form.validate(valid_data)).to be_false
    end

    specify 'short password' do
      valid_data[:password] = 'iron'
      expect(form.validate(valid_data)).to be_false
    end

    specify "password confirmation is required" do
      valid_data[:password_confirmation] = ''
      expect(form.validate(valid_data)).to be_false
    end

    specify "password confirmation doesn't match" do
      valid_data[:password_confirmation] = 'no match here!'
      expect(form.validate(valid_data)).to be_false
    end
  end
end
