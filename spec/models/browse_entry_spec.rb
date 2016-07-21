RSpec.describe BrowseEntry do
  it { is_expected.to have_many(:page_elements).dependent(:destroy) }
  it { is_expected.to have_many(:pages).through(:page_elements) }
  it { is_expected.to have_and_belong_to_many(:collections) }
  it { is_expected.to belong_to(:media_object) }
  it { is_expected.to delegate_method(:file).to(:media_object) }
  it { is_expected.to accept_nested_attributes_for(:media_object) }

  describe '.subject_types' do
    subject { described_class.subject_types.keys }
    it { is_expected.to eq(%w(topic person)) }
  end
end
