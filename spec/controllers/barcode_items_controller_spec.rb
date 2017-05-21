RSpec.describe BarcodeItemsController, type: :controller do
  let(:default_params) {
    { organization_id: @organization.to_param }
  }

  context "While signed in" do
    before do
      sign_in(@user)
    end

    describe "GET #index" do
      subject { get :index, params: default_params }
      it "returns http success" do
        expect(subject).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      subject { get :new, params: default_params }
      it "returns http success" do
        expect(subject).to be_successful
      end
    end

    describe "GET #edit" do
      subject { get :edit, params: default_params.merge({ id: create(:barcode_item) }) }
      it "returns http success" do
        expect(subject).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      subject { get :show, params: default_params.merge({ id: create(:barcode_item) }) }
      it "returns http success" do
        expect(subject).to be_successful
      end
    end

    describe "DELETE #destroy" do
      subject { delete :destroy, params: default_params.merge({ id: create(:barcode_item) }) }
      it "redirecst to the index" do
        expect(subject).to redirect_to(barcode_items_path)
      end
    end

    context "Looking at a different organization" do
      let(:object) { create(:barcode_item, organization: create(:organization) ) }
      include_examples "requiring authorization"
    end

    context "GET" do
      let!(:item) { create(:item) }
      let!(:barcode) { create(:barcode_item, item: item, organization_id: item.organization_id) }
      let!(:find_barcode_response) { {value: barcode.value, item_id: item.id, quantity: barcode.quantity} }

      it "retreaves a JSON object of the barcode" do
        headers = { "ACCEPT" => "application/json" }
        get :find, headers: headers, params: default_params.merge({ value: barcode.value })

        # get "/#{item.organization.to_param}/barcode_items/find", params: {value: barcode.value}

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(find_barcode_response.to_json)
      end
    end
  end

  context "While not signed in" do
    let(:object) { create(:barcode_item) }

    include_examples "requiring authentication"
  end

end
