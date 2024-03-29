#!/bin/env ruby
# encoding: utf-8

# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  email                          :string(255)      default(""), not null
#  encrypted_password             :string(255)      default(""), not null
#  reset_password_token           :string(255)
#  reset_password_sent_at         :datetime
#  remember_created_at            :datetime
#  sign_in_count                  :integer          default(0), not null
#  current_sign_in_at             :datetime
#  last_sign_in_at                :datetime
#  current_sign_in_ip             :string(255)
#  last_sign_in_ip                :string(255)
#  agreed_to_terms_and_conditions :boolean
#  trip_rating                    :integer
#  summary                        :string(255)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  neighborhood                   :string(255)
#  confirmation_token             :string(255)
#  confirmed_at                   :datetime
#  confirmation_sent_at           :datetime
#  first_name                     :string(255)
#  last_name                      :string(255)
#  unconfirmed_email              :string(255)
#  phone                          :string(255)
#  driver                         :boolean
#  avatar_file_name               :string(255)
#  avatar_content_type            :string(255)
#  avatar_file_size               :integer
#  avatar_updated_at              :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :summary, :neighborhood, :first_name, :last_name, :agreed_to_terms_and_conditions, :trip_rating, :current_password, :driver, :phone, :avatar
  
  validates_presence_of :first_name, :last_name, :email, message: "alani bos olamaz"
  validates_inclusion_of :agreed_to_terms_and_conditions, in: [true], on: :create
  validates_length_of :password, within: 8..20, on: :create
  validate :valid_email_domain
  
  has_many :postings
  has_many :frequent_postings
  has_many :comments
  has_many :favorites
  has_many :posting_responses, :class_name => "PostingResponse", :foreign_key => "responder_id"

  before_save :titleize_name
  
  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    icon: '45x45',
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }, :default_url => "missing.png"

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  def confirm!
    send_welcome_message
    super
  end
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
  def calculate_rating
    Rails.cache.fetch("users/#{self.id}/rating") do
      comments_sum = Comment.find_all_by_is_about(self.id).collect { |comment| comment.rating }.sum
      total_comments = Comment.find_all_by_is_about(self.id).count
      result = 0
      if total_comments > 0
        result = self.trip_rating = comments_sum / total_comments
      end
      self.update_attribute(:trip_rating, result)
      result
    end
  end

  def has_past_postings?
    postings_empty = self.postings.past_postings.empty? ? false : true
    posting_responses = past_posting_responses
    posting_responses_empty = posting_responses.empty? ? false : true
    postings_empty && posting_responses_empty
  end
  
  def has_past_responses?
    responses_empty = self.posting_responses.past.empty? ? false : true
    accepted_responses = accepted_past_responses
    accepted_responses_empty = accepted_responses.empty? ? false : true
    responses_empty && accepted_responses_empty
  end
  
  def has_showable_journeys?
    has_past_postings? || has_past_responses?
  end
  
  def accepted_past_responses
    responses = []
    self.posting_responses.includes([posting: :user, user: :postings]).past.each do |response|
      responses << response if response.accepted == true && response.responder_agreed.nil?
    end
    responses
  end
  
  def unagreed_postings
    responses = []
    self.postings.past_postings.includes(:posting_responses).each do |posting|
      posting.posting_responses.each do |response|
        responses << response if response.accepted && response.poster_agreed.nil?
      end
    end
    responses
  end
  
  def agreed_journeys
    Rails.cache.fetch("users/#{self.id}/agreed_journeys") do 
      (self.postings.past_postings.includes(:user) << self.posting_responses.past.map { |response| response.posting if response.accepted && !response.responder_agreed.nil? }).flatten.delete_if { |posting| posting.nil? }.reverse
    end
  end
  
  def total_journeys
    self.postings.past_postings.count + self.posting_responses.past.select { |response| response if response.accepted && !response.responder_agreed.nil? }.count
  end
  
  private
  
  def past_posting_responses
    postings = []
    self.postings.past_postings.each do |posting|
      if !posting.posting_responses.empty?
        posting.posting_responses.each do |response|
          postings << posting if response.accepted && response.poster_agreed.nil?
          break
        end
      end
    end
    postings
  end
  
  def titleize_name
    self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
  end
  
  def valid_email_domain
    valid = false
    VALID_DOMAINS.each do |d|
      if /#{d}$/ =~ self.email
        valid = true
      end
    end
    if valid
      return true
    else
      errors.add(:email, "lütfen KU mailini gir")
    end
  end
  
  def send_welcome_message
    UserMailer.welcome(self.id).deliver
  end
  
end
