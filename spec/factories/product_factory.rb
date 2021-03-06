FactoryBot.define do

  factory :product do
    name "Product"
    description "This is a product"
    colour "colour"
    price "100"
    image_url "/image"

    factory :product_with_comments do
      transient do
        comments_count 3
      end

      after(:build) do |product, evaluator|
        create_list(:comment, evaluator.comments_count, product: product)
      end
    end
  end

  factory :invalid_product, parent: :product do |f|
    f.name nil
  end

end
