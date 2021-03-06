class Product < ApplicationRecord
    has_many :orders
    has_many :comments

    validates :name, presence: true
    validates :description, presence: true
    validates :image_url, presence: true
    validates :colour, presence: true
    validates :price, presence: true, numericality: true


    def self.search(search_term)
      if Rails.env.production?
        Product.where("name ilike ?", "%#{search_term}%")
      else
        Product.where("name LIKE ?", "%#{search_term}%")
      end
    end

    def highest_rating_comment
      comments.rating_desc.first
    end

    def lowest_rating_comment
      comments.rating_asc.first
    end

    def average_rating
      comments.average(:rating).to_f
    end

    def cached_comments_count
      Rails.cache.fetch([self, "comments_count"]) {comments.size}
    end

    def cached_comments
      Rails.cache.fetch([self, "comments"]) {comments}
    end
end
