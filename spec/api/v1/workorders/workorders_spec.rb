require 'spec_helper'

describe 'GET /v1/workorders/:id' do
  
  it 'returns a workorder by :id' do
    user = create(:user)
    workorder = create(:workorder, user: user)
    get "/v1/workorders/#{workorder.id}"
    expect(response_json).to eq(
      {
        'customer' => workorder.customer,
        'address' => workorder.address,
        'phone' => workorder.phone,
        'user' => {
          'device_token' => workorder.user.device_token
        }
      }
    )
  end
end

describe 'POST /v1/workorders/:id' do

  it 'saves the customer name, address, phone' do
    device_token = '1234abcd456789'
    user = create(:user, device_token: device_token)

    post 'v1/workorders', {
      customer: "New Customer",
      address: "1234 2nd Street",
      phone: 123456789,
      user: {
        device_token: device_token
      }
    }.to_json, { 'Content-Type' => 'application/json' }

    workorder = Workorder.last
    expect(response_json).to eq({ 'id'=>workorder.id })
    expect(workorder.address).to eq "1234 2nd Street"
    expect(workorder.phone).to eq 123456789
    expect(workorder.user).to eq user

  end

  it 'returns an error message when invalid do' do
    post '/v1/workorders',
      {}.to_json, {'Content-Type' => 'application/json'}

    expect(response_json).to eq({
      'message' => 'Validation Failed',
      'errors' => [
        "Customer can't be blank",
        "Address can't be blank",
        "Phone can't be blank"
      ]
    })
    expect(response.code.to_i).to eq 422
  end
end

describe 'PATCH /v1/events/:id' do
  it 'updates the workorder attributes' do
    workorder=create(:workorder, customer: "Old Customer")
    new_name = "New Name"

    patch "/v1/workorders/#{workorder.id}", {
      customer: new_name,
      address: workorder.address,
      phone: workorder.phone,
      user: { 
        device_token: workorder.user.device_token 
      }
    }.to_json, { 'Content-Type' => 'application/json' }
      workorder=Workorder.last
      expect(workorder.customer).to eq new_name
      expect(response_json).to eq({'id' => workorder.id})
  end

  it 'returns errors if update fails' do
    workorder=create(:workorder)

    patch "/v1/workorders/#{workorder.id}",{
      customer: nil,
      phone: workorder.phone,
      address: workorder.address,
        user: {
          device_token: workorder.user.device_token
        }
    }.to_json, { 'Content-Type' => 'application/json' }

    workorder = Workorder.last
    expect(workorder.customer).to_not be nil
    expect(response_json).to eq({
      'message' => 'Validation Failed',
      'errors' => [
        "Customer can't be blank"
      ]
    })
    expect(response.code.to_i).to eq 422
  end
end

