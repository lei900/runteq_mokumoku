RSpec.shared_context "user setup" do
  let!(:user) { create(:user, name: 'user') }
  let!(:other_user) { create(:user, name: 'other_user') }
  let!(:my_event) { create(:event, title: '自分が主催するもくもく会', user: user) }
  let!(:other_event) { create(:event, title: '他人が主催するもくもく会', user: other_user) }

  before { login_as(user) }
end