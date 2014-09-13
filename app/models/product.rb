class Product < ActiveRecord::Base
  validates_presence_of :name, :price
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  validates_uniqueness_of :code, :allow_nil => true, :allow_blank => true
  validates_uniqueness_of :name, :scope => :code

  belongs_to :provider
  has_many :orders
  has_many :product_tags
  has_many :tags, through: :product_tags

  accepts_nested_attributes_for :product_tags, :allow_destroy => true

  def provider_name=(provider_name)
    self.provider = Provider.where({:name => provider_name}).first_or_create! do |provider|
      provider.name = provider_name
    end
  end

  def provider_code=(provider_code)
    if self.provider && self.provider.code.to_s == ''
      self.provider.code = provider_code
      self.provider.save!
    end
  end

  def tag_names=(tag_names)
    pa = self.attributes
    product = Product.new(pa)

    return false if !product.save
    if tag_names.to_s != ''
      tag_names = tag_names.split(',')
      tag_names.each do |tag_name|
        tag = Tag.where({:name => tag_name}).first_or_create! do |tag|
          tag.name = tag_name
        end
          product.product_tags.create({:tag_id => tag.id})
      end
    end
  end
end
