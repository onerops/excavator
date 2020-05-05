describe "TicketOperation::Action::List"  do

  subject(:operation){ TicketOperation::Action::List.new( {page: page} ) }

  before(:each) do
    create(:ticket)
    operation.process
  end
  
  context "with existed page" do
    let(:page) { 1 }
    it "should return correct pages count" do
      expect( operation.result ).to eq(1)
    end

    it "should return list of tickets" do
      expect(operation.model).to have(1).items
    end

  end

  context "with unexisted page" do 
    let(:page) { 100_500 }
    it "should return correct pages count" do
      expect( operation.result ).to eq(1)
    end

    it "should return empty list" do
      expect(operation.model).to be_empty
    end

  end

end
