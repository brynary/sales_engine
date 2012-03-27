require 'spec_helper'

describe SalesEngine::Customer do
  let(:customer) { SalesEngine::Customer.find_by_id 999 }

  context "Relationships" do
    describe ".random" do
      it "usually returns different things on subsequent calls" do
        customer_one = SalesEngine::Customer.random
        10.times do
          customer_two = SalesEngine::Customer.random
          break if customer_one.id != customer_two.id
        end

        customer_one.id.should_not == customer_two.id
      end
    end

    describe ".find_by_last_name" do
      customer = SalesEngine::Customer.find_by_last_name "Ullrich"
      customer.first_name.should == "Ramon"
    end

    describe ".find_all_by_first_name" do
      customers = SalesEngine::Customer.find_all_by_first_name "Sasha"
      customers.should have(2).customers
    end
  end

  context "Relationships" do
    describe "#invoices" do
      it "returns all of a customer's invoices" do
        customer.invoices.should have(7).invoices
      end

      it "returns invoices belonging to the customer" do
        customer.invoices.each do |invoice|
          invoice.customer_id.should == 999
        end
      end
    end

  end

  context "Business Intelligence" do
    let(:customer) { SalesEngine::Customer.find_by_id 2 }

    describe "#transactions" do
      it "returns a list of transactions the customer has had" do
        customer.transactions.should have(1).transaction
      end
    end

    describe "#favorite_merchant" do
      it "returns the merchant where the customer has had the most transactions" do
        customer.favorite_merchant.name.should == "Shields, Hirthe and Smith"
      end
    end
  end
end

