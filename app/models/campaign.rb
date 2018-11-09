class Campaign < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  # mount_uploader :image, CampaignImageUploader
  has_one :campaign_image

  default_scope { where(active: true) }
  scope :normal_state, -> { where(status: 3) }

  has_many :goodies, dependent: :destroy
  has_many :supporters, through: :goodies
  has_many :orders, through: :goodies
  has_many :campaign_updates
  has_many :campaign_replies
  has_many :tracks
  has_many :campaign_qas
  has_many :campaign_groups
  has_many :campaign_tag_ships
  has_many :campaign_tags, :through => :campaign_tag_ships

  accepts_nested_attributes_for :campaign_groups
  accepts_nested_attributes_for :campaign_image, update_only: true #allow_destroy: true

  belongs_to :user

  validates_presence_of :description
  validates :goal, numericality: true, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validate :end_date, :is_end_before_start?

  before_save :use_youtube_embedd_url

  # before_save :convert_descriptions

  def amount_raised
    goodies.inject(0) do |sum, g|
      sum += g.orders ? g.orders.is_paid.sum{ |p| p.amount + p.bonus.to_i }  : sum
    end
  end

  def parent_comments()
    campaign_replies.where(parent_id: 0, enabled: true)
  end

  def sub_comments
    campaign_replies.where([ "parent_id != 0" ])
  end

  def is_active?
    start_date <= Date.today &&
    end_date >= Date.today
  end

  def input_campaign_image
    self.campaign_image ||= self.build_campaign_image
  end

  private

  # Regular Youtube URLs cannot be embedded into an iframe
  def use_youtube_embedd_url
    if youtube_url =~ /watch/
      youtube_url.sub!("watch?v=", "embed/")
    end
  end

  def convert_descriptions
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new,
                                       fenced_code_blocks: true)
    self.description_html = renderer.render(description) if description
    self.order_description_html = renderer.render(order_description) if order_description
    self.order_success_html = renderer.render(order_success) if order_success
  end

  def is_end_before_start?
    if end_date and start_date
      errors.add(:end_date, "End date has to be after the start date!") if end_date < start_date
    end
  end


end
