#
# REST API Request Tests - Regions
#
# Regions primary collections:
#   /api/regions
#
# Tests for:
# GET /api/regions/:id
#

describe "Regions API" do
  it "forbids access to regions without an appropriate role" do
    api_basic_authorize

    get(api_regions_url)

    expect(response).to have_http_status(:forbidden)
  end

  it "forbids access to a region resource without an appropriate role" do
    api_basic_authorize

    region = FactoryGirl.create(:miq_region, :region => "2")

    get(api_region_url(nil, region))

    expect(response).to have_http_status(:forbidden)
  end

  it "allows GETs of a region" do
    api_basic_authorize action_identifier(:regions, :read, :resource_actions, :get)

    region = FactoryGirl.create(:miq_region, :region => "2")

    get(api_region_url(nil, region))

    expect(response).to have_http_status(:ok)
    expect(response.parsed_body).to include(
      "href" => api_region_url(nil, region),
      "id"   => region.id.to_s
    )
  end
end
