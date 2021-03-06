require 'rails_helper'

describe Comment do
  context "create new comment validation" do
    before do
      @product = FactoryBot.create(:product)
      @user = FactoryBot.create(:user)
      @attrs = FactoryBot.attributes_for(:comment, product_id: @product.id, user_id: @user.id)
    end

    it "is not valid without a user" do
      @comment = Comment.new(@attrs.except(:user_id))
      expect(@comment).to_not be_valid
    end

    it "is not valid without a product" do
      @comment = Comment.new(@attrs.except(:product_id))
      expect(@comment).to_not be_valid
    end

    it "is not valid without a body" do
      @comment = Comment.new(@attrs.except(:body))
      expect(@comment).to_not be_valid
    end

    it "is not valid without a rating" do
      @comment = Comment.new(@attrs.except(:rating))
      expect(@comment).to_not be_valid
    end

    it "is not valid without a rating number" do
      @comment = FactoryBot.build(:comment, rating: "string")
      expect(@comment).to_not be_valid
    end
  end
end
