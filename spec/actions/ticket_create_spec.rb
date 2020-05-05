describe "TicketOperation::Action::Create"  do

  subject(:operation){ TicketOperation::Action::Create.new( params ) }
  
  context "with valid params" do

    let(:params) { JSON.load(load_file('valid_request.json')) }

    before do
      operation.process
    end

    it "should have not an errors on operation" do
      expect( operation.errors ).to be_empty 
    end

    it "should create new ticket and excavator" do
      expect{ operation.process }.to change(Ticket, :count).by(1) 
      expect{ operation.process }.to change(Excavator, :count).by(1) 
    end

    context "and invalid unnecessary data" do 
      let(:params) { JSON.load(load_file('invalid_unnecessary_request.json')) }
      it "should create new ticket" do
        expect{ operation.process }.to change(Ticket, :count).by(1) 
        expect{ operation.process }.to change(Excavator, :count).by(1) 
      end

    end

  end

  context "with invalid params" do 

    before(:each) do
      operation.process
    end


    let(:params) { JSON.load(load_file('invalid_request.json')) }
    it "result should be nil" do
      expect( operation.result ).to be_nil
    end

    context "when excavator invalid" do 
      let(:params) { JSON.load(load_file('invalid_excavator_request.json')) }
      it "should have an error on excavator field" do
        expect( operation.errors.keys ).to include(:excavator)
      end

    end

    context "when ticket invalid" do 
      let(:params) { JSON.load(load_file('invalid_ticket_request.json')) }
      it "should have an error on date_times field" do
        expect( operation.errors.keys ).to include(:date_times)
      end

    end

  end

end
