describe "TicketOperation::Action::Read"  do

  subject(:operation){ TicketOperation::Action::Read.new( {id: id} ) }

  before(:each) do
    create(:ticket,id:1)
    operation.process
  end

  context "with existed ticket" do 
    let(:id){ 1 }
    it "should return ticket" do
      expect( operation.model ).to be_an_instance_of(Ticket)
    end

    it "should have not an errors on operation" do
      expect( operation.errors ).to be_empty 
    end

  end
  context "with unexisted ticket" do 
    let(:id){ 100_500 }

    it "should have an errors on operation" do
      expect( operation.errors ).to_not be_empty 
    end

    it "should not return ticket" do
      expect( operation.model ).to be_nil 
    end

  end

end
