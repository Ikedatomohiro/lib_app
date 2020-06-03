require 'rails_helper'

RSpec.describe User, type: :model do

    describe '#provider' do
        context 'twitterからのログインの場合' do
            let(:user){User.new(provider: 'twitter')}

            it 'twitterからのログインであること' do
                expect(user.provider).to eq 'twitter'
            end
        end
    end
end
